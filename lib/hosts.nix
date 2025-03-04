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

  exportFolder = folder: let
    dir = builtins.readDir folder;
    names = builtins.attrNames dir;

    hasSuffix = suffix: str:
      builtins.stringLength str
      >= builtins.stringLength suffix
      && builtins.substring
      (builtins.stringLength str - builtins.stringLength suffix)
      (builtins.stringLength suffix)
      str
      == suffix;

    removeSuffix = suffix: str:
      if hasSuffix suffix str
      then
        builtins.substring 0
        (builtins.stringLength str - builtins.stringLength suffix)
        str
      else str;

    isNixFile = n: dir.${n}.type == "regular" && hasSuffix ".nix" n;

    isNixDir = n:
      dir.${n}.type
      == "directory"
      && (builtins.readDir (folder + "/" + n) ? "default.nix");

    validNames =
      builtins.filter (n: !startsWith "_" n && (isNixFile n || isNixDir n))
      names;
  in
    lib.genAttrs validNames (n:
      if isNixFile n
      then {
        name = removeSuffix ".nix" n;
        value = import (folder + "/" + n);
      }
      else {
        name = n;
        value = import (folder + "/" + n + "/default.nix");
      });

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

    isDarwin = system: builtins.match ".*-darwin" system != null;

    mkHost = hostName: let
      isDarwin' = isDarwin host.system;

      moduleName =
        if isDarwin'
        then "darwinModules"
        else "nixosModules";
      defaultModules =
        if
          (host.output
            == "darwinConfigurations"
            || host.output == "nixosConfigurations")
        then [
          ({lib, ...}: {networking.hostName = lib.mkDefault hostName;})
          {_module.args = host.extraArgs;}
          (
            if isDarwin'
            then ./modules/darwin
            else ./modules/nixos
          )
          inputs.home-manager.${moduleName}.home-manager
          inputs.agenix.${moduleName}.default
        ]
        else [];

      host =
        shallowMerge {
          system = "x86_64-linux";
          modules = defaultModules;
          extraArgs = {};
          specialArgs = args;
          builder =
            if isDarwin'
            then inputs.darwin.lib.darwinSystem
            else inputs.nixpkgs.lib.nixosSystem;

          output =
            if isDarwin'
            then "darwinConfigurations"
            else "nixosConfigurations";
        }
        mergedHosts.${hostName};
    in {
      name = host.output;
      value = host.builder {inherit (host) system specialArgs modules;};
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

  mkHosts = folder: args:
    mkHosts' {
      inherit args;
      hosts = exportFolder folder;
    };
}
