{lib, ...}: let
  inherit
    (builtins)
    map
    filter
    attrNames
    mapAttrs
    removeAttrs
    isAttrs
    isList
    isFunction
    substring
    toString
    match
    readDir
    pathExists
    elem
    ;
  inherit (lib.strings) removeSuffix hasSuffix;
  inherit (lib.attrsets) optionalAttrs genAttrs;
  inherit (lib.lists) optionals foldl';
in rec {
  shallowMerge = lhs: rhs:
    lhs
    // mapAttrs (name: value:
      if isAttrs value
      then lhs.${name} or {} // value
      else if isList value
      then lhs.${name} or [] ++ value
      else lhs.${name} or value)
    rhs;

  mergeDefault = attr: let
    def = attr.default or {};
  in
    mapAttrs (_: subAttr: shallowMerge subAttr def)
    (removeAttrs attr ["default"]);

  startsWith = prefix: str:
    substring 0 (builtins.stringLength prefix) str == prefix;

  contains = substring: string: let
    regex = ".*" + substring + ".*";
  in
    match regex string != null;

  isDarwin = s: contains "darwin" s;

  isNixos = s: contains "nixos" s;

  isHome = s: contains "home" s;

  isNixOnDroid = s: contains "nixOnDroid" s;

  shallowLoad = dir: args: let
    dirStr = toString dir;
    entries = readDir dir;
    entryNames = attrNames entries;

    validFileNames =
      map (n: removeSuffix ".nix" n)
      (filter (n: entries.${n} == "regular" && hasSuffix ".nix" n)
        entryNames);

    validDirNames = filter (n:
      entries.${n} == "directory" && pathExists "${dirStr}/${n}/default.nix")
    entryNames;

    finalNames = validFileNames ++ validDirNames;
  in
    genAttrs finalNames (n: let
      imported =
        if elem n validFileNames
        then import "${dirStr}/${n}.nix"
        else import "${dirStr}/${n}";
    in
      if isFunction imported
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
    inherit (specialArgs) self inputs lib withSystem;
    getHostBuilder = output: let
      builders = {
        homeConfigurations =
          inputs.home-manager.lib.homeManagerConfiguration;
        nixosConfigurations = inputs.nixpkgs.lib.nixosSystem;
        darwinConfigurations = inputs.darwin.lib.darwinSystem;
        nixOnDroidConfigurations = inputs.droid.lib.nixOnDroidConfiguration;
      };
    in
      builders.${output};
    mergedHosts = mergeDefault hosts;

    hostNames = attrNames mergedHosts;

    mkHost = hostName: let
      rawHost = mergedHosts.${hostName};

      isDarwin' =
        if rawHost ? system
        then isDarwin rawHost.system
        else false;

      host = shallowMerge rawHost {
        system = "x86_64-linux";
        modules = [
          ({options, ...}: {
            # 'mkMerge` to separate out each part into its own module
            _type = "merge";
            contents = [
              (optionalAttrs (options ? networking.hostName) {
                networking.hostName = hostName;
              })
              (optionalAttrs (options ? nixpkgs.hostPlatform) {
                nixpkgs.hostPlatform = lib.mkDefault host.system;
              })
            ];
          })
        ];
        output =
          if isDarwin'
          then "darwinConfigurations"
          else "nixosConfigurations";
      };
      isDarwinOutput = isDarwin host.output;
      isNixosOutput = isNixos host.output;
      isHomeOutput = isHome host.output;
      isNixOnDroidOutput = isNixOnDroid host.output;
      mkArgs = system:
        withSystem system (args: {
          inherit self inputs lib;
          inherit (args) self' inupts';
          inherit hostName;
        });
    in {
      inherit (host) output;
      config =
        {
          inherit (host) system;
          modules =
            host.modules
            ++ (optionals isDarwinOutput [
              ../modules/darwin
              inputs.home-manager.darwinModules.home-manager
              inputs.agenix.darwinModules.default
              # since agenix-rekey has no darwin module, we use the nixos one
              inputs.agenix-rekey.nixosModules.default
            ])
            ++ (optionals isNixosOutput [
              ../modules/nixos
              inputs.home-manager.nixosModules.home-manager
              inputs.agenix.nixosModules.default
              inputs.agenix-rekey.nixosModules.default
              inputs.disko.nixosModules.disko
              inputs.nixos-generators.nixosModules.all-formats
              inputs.programs-sqlite.nixosModules.programs-sqlite
            ])
            ++ (optionals isHomeOutput [
              ../modules/home
            ]);
        }
        // (optionalAttrs (isDarwinOutput || isNixosOutput) {
          specialArgs = mkArgs host.system;
        })
        // (optionalAttrs (isHomeOutput || isNixOnDroidOutput) {
          extraSpecialArgs = mkArgs host.system;
        });
      builder = getHostBuilder host.output;
    };
  in
    foldl' (acc: hostName: let
      out = mkHost hostName;
      inherit (out) output;
    in
      acc
      // {
        "${output}" =
          (acc.${output} or {})
          // {
            "${hostName}" = out.builder out.config;
          };
      }) {nodes = mergedHosts;}
    hostNames;

  mkHosts = dir: specialArgs:
    mkHosts' {
      hosts = shallowLoad dir specialArgs;
      inherit specialArgs;
    };
}
