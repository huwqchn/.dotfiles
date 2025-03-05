{lib, ...}: rec {
  shallowMerge = lhs: rhs:
    lhs
    // builtins.mapAttrs (name: value:
      if builtins.isAttrs value
      then lhs.${name} or {} // value
      else if builtins.isList value
      then lhs.${name} or [] ++ value
      else value)
    rhs;

  mergeDefault = attr: let
    def = attr.default or {};
  in
    builtins.mapAttrs (_: subAttr: shallowMerge subAttr def)
    (builtins.removeAttrs attr ["default"]);

  startsWith = prefix: str:
    builtins.substring 0 (builtins.stringLength prefix) str == prefix;

  hasSuffix = suffix: str:
    builtins.stringLength str
    >= builtins.stringLength suffix
    && builtins.substring
    (builtins.stringLength str - builtins.stringLength suffix)
    (builtins.stringLength suffix)
    str
    == suffix;

  contains = substr: str:
    builtins.match (".*" + substr + ".*") str != null;

  isDarwin = s: contains s "darwin";

  removeSuffix = suffix: str:
    if hasSuffix suffix str
    then
      builtins.substring 0
      (builtins.stringLength str - builtins.stringLength suffix)
      str
    else str;
  shallowLoad = dir: args: let
    dirStr = builtins.toString dir;
    entries = builtins.readDir dir;
    entryNames = builtins.attrNames entries;

    validFileNames =
      builtins.map (n: removeSuffix ".nix" n)
      (builtins.filter (n: entries.${n} == "regular" && hasSuffix ".nix" n)
        entryNames);

    validDirNames = builtins.filter (n:
      entries.${n}
      == "directory"
      && builtins.pathExists "${dirStr}/${n}/default.nix")
    entryNames;

    finalNames = validFileNames ++ validDirNames;
  in
    lib.genAttrs finalNames (n:
      if builtins.elem n validFileNames
      then import "${dirStr}/${n}.nix" args
      else import "${dirStr}/${n}" args);

  mkHosts' = {
    hosts ? {
      default = {
        system = "x86_64-linux";
        modules = [];
        extraArgs = {};
      };
    },
    args,
  }: let
    inherit (args) inputs;

    mergedHosts = mergeDefault hosts;

    hostNames = builtins.attrNames mergedHosts;

    mkHost = hostName: let
      host =
        shallowMerge {
          system = "x86_64-linux";
          modules = [
            ({options, ...}: {
              # 'mkMerge` to separate out each part into its own module
              _type = "merge";
              contents = [
                (builtins.optionalAttrs (options ? networking.hostName) {
                  networking.hostName = hostName;
                })
                {_module.args = host.extraArgs;}
              ];
            })
          ];
          extraArgs = {};
          specialArgs = args;
          builder = inputs.nixpkgs.lib.nixosSystem;
          output = "nixosConfigurations";
        } mergedHosts.${hostName};
    in {
      name = host.output;
      value = host.builder {
        inherit (host) system specialArgs hosts modules;
      };
    };
  in
    lib.foldl' (acc: hostName: let
      out = mkHost hostName;
    in
      acc
      // {
        ${out.name} = (acc.${out.name} or {}) // {${hostName} = out.value;};
      }) {}
    hostNames;

  mkHosts = dir: args:
    mkHosts' {
      inherit args;
      hosts = shallowLoad dir args;
    };
}
