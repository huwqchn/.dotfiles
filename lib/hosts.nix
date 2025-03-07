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

  contains = substring: string: let
    regex = ".*" + substring + ".*";
  in
    builtins.match regex string != null;

  isDarwin = s: contains "darwin" s;

  isNixos = s: contains "nixos" s;

  shallowLoad = dir: args: let
    dirStr = builtins.toString dir;
    entries = builtins.readDir dir;
    entryNames = builtins.attrNames entries;

    validFileNames =
      builtins.map (n: lib.strings.removeSuffix ".nix" n)
      (builtins.filter
        (n: entries.${n} == "regular" && lib.strings.hasSuffix ".nix" n)
        entryNames);

    validDirNames = builtins.filter (n:
      entries.${n}
      == "directory"
      && builtins.pathExists "${dirStr}/${n}/default.nix")
    entryNames;

    finalNames = validFileNames ++ validDirNames;
  in
    lib.genAttrs finalNames (n: let
      imported =
        if builtins.elem n validFileNames
        then import "${dirStr}/${n}.nix"
        else import "${dirStr}/${n}";
    in
      if builtins.isFunction imported
      then imported args
      else imported);

  mkHosts' = {
    hosts ? {
      default = {
        system = "x86_64-linux";
        modules = [];
        extraArgs = {};
      };
    },
    specialArgs,
  }: let
    mergedHosts = mergeDefault hosts;

    hostNames = builtins.attrNames mergedHosts;

    mkHost = hostName: let
      rawHost = mergedHosts.${hostName};

      isDarwin' =
        if rawHost ? system
        then isDarwin rawHost.system
        else false;

      host =
        shallowMerge {
          system = "x86_64-linux";
          modules = [
            ({options, ...}: {
              # 'mkMerge` to separate out each part into its own module
              _type = "merge";
              contents = [
                (lib.optionalAttrs (options ? networking.hostName) {
                  networking.hostName = hostName;
                })
                {_module.args = specialArgs // host.extraArgs;}
              ];
            })
          ];
          extraArgs = {};
          specialArgs = inputs;
          builder =
            if isDarwin'
            then inputs.darwin.lib.darwinSystem
            else inputs.nixpkgs.lib.nixosSystem;
          output =
            if isDarwin'
            then "darwinConfigurations"
            else "nixosConfigurations";
        }
        rawHost;
      isDarwinOutput = isDarwin host.output;
      isNixosOutput = isNixos host.output;
    in {
      output = host.output;
      config =
        {
          inherit (host) system;
          modules =
            host.modules
            ++ (lib.optionals isDarwinOutput [
              ../modules/darwin
              inputs.home-manager.darwinModules.home-manager
              inputs.agenix.darwinModules.default
            ])
            ++ (lib.optionals isNixosOutput [
              ../modules/nixos
              inputs.home-manager.nixosModules.home-manager
              inputs.agenix.nixosModules.default
            ]);
        }
        // (lib.optionalAttrs (isDarwinOutput || isNixosOutput) {
          inherit (host) specialArgs;
        })
        // (lib.optionalAttrs (!isDarwinOutput && !isNixosOutput) {
          extraSpecialArgs = host.specialArgs;
        });
      inherit (host) builder;
    };
  in
    lib.foldl' (acc: hostName: let
      out = mkHost hostName;
    in
      acc
      // {
        ${out.output}.${hostName} = out.builder out.config;};
      }) {}
    hostNames;

  mkHosts = dir: specialArgs:
    mkHosts' {
      inherit specialArgs;
      hosts = shallowLoad dir specialArgs;
    };
}
