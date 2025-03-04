{ lib, ... }: {
  shallowMerge = lhs: rhs:
    lhs // builtins.mapAttrs
    (name: value:
      if builtins.isAttrs value then lhs.${name} or { } // value
      else if isList value then lhs.${name} or [ ] ++ value
      else value
    ) rhs;
  mergeDefault = attr:
    let
      def = attr.default or { };
      merged = lib.mapAttrs (name: value:
        if builtins.isAttrs value then
          def // value
        else value
      ) attr;
    in
      lib.removeAttrs merged [ "default" ];

  exportFolder = folder:
    let
      dir   = builtins.readDir folder;
      names = builtins.attrNames dir;

      hasSuffix = suffix: str:
        builtins.stringLength str >= builtins.stringLength suffix &&
        builtins.substring
          (builtins.stringLength str - builtins.stringLength suffix)
          (builtins.stringLength suffix)
          str == suffix;

      removeSuffix = suffix: str:
        if hasSuffix suffix str
        then builtins.substring 0 (builtins.stringLength str - builtins.stringLength suffix) str
        else str;

      isNixFile = n:
        dir.${n}.type == "regular" && hasSuffix ".nix" n;

      isNixDir = n:
        dir.${n}.type == "directory" &&
        (builtins.readDir (folder + "/" + n) ? "default.nix");

      validNames =
        builtins.filter (n:
          !builtins.stringStartsWith "_" n
          && (isNixFile n || isNixDir n)
        ) names;

    in
    lib.genAttrs validNames (n:
      if isNixFile n
      then {
        name  = removeSuffix ".nix" n;
        value = import (folder + "/" + n);
      } else {
        name  = n;
        value = import (folder + "/" + n + "/default.nix");
      }
    );

  mkHosts' = {
    hosts ? {
      default = {
        system   = "x86_64-linux";
        modules  = [];
        extraArgs= {};
      };
    },
    args,
  }:
  let
    mergedHosts = mergeDefault hosts;

    hostNames = builtins.attrNames mergedHosts;

    isDarwin = system: builtins.match ".*-darwin" system != null;

    isDarwin' = isDarwin host.system;

    moduleName = if isDarwin' then "darwinModules" else "nixosModules";
    mkHost = hostName:
      let
        host = shallowMerge {
          system = "x86_64-linux";
          modules = [
            (if isDarwin' then ./modules/darwin else ./modules/nixos)
            inputs.home-manager.${moduleName}.home-manager
            inputs.agenix.${moduleName}.default
          ];
          extraArgs = {};
          specialArgs = args;
          builder = null;
          output = null;
        } mergedHosts.${hostName};
        builder =
          if host.builder == null then
            if isDarwin host.system
            then inputs.darwin.lib.darwinSystem
            else inputs.nixpkgs.lib.nixosSystem
          else host.builder;

        output =
          if conf.output == null then
            if isDarwin conf.system
            then "darwinConfigurations"
            else "nixosConfigurations"
          else host.output;

        builtHost = builder {
          inherit (host) system specialArgs;
          modules = host.modules ++ [
            {lib, ...}: {
              networking.hostName = lib.mkDefault hostName;
            }
            { _module.args = host.extraArgs; }
          ];
        };
      in {
        name = output;
        value = builtHost;
      };
    foldHosts = lib.foldl' (acc: hostName:
      let out = mkHost hostName;
      acc // {
        ${out.name} = (acc.${out.name} or { }) // {
          ${homeName} = out.value;
        };
      }
    ) {} hostNames;
  in
    foldHosts;

  mkHosts = {
    folder,
    args,
  }:
    mkHosts' {
      inherit args;
      hosts = exportFolder folder;
    };
}
