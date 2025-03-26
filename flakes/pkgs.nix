{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem = {
    lib,
    config,
    system,
    ...
  }: let
    inherit (lib.filesystem) packagesFromDirectoryRecursive;
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        self.overlays.default
      ];
      config = {
        allowAliases = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
    };
  in {
    # two ways to use flake-parts pkgs
    # 1. use withSystem
    # e.g.
    # flake.nixosConfigurations.a =
    #     withSystem "x86_64-linux" ({ pkgs, system, ... }: nixpkgs.lib.nixosSystem {
    #       inherit pkgs system;
    #       modules = [ ];
    #     });
    # 2. use getSystem
    # e.g.
    # flake.nixosConfigurations.a = let system = "x86_64-linux"; in
    #     nixpkgs.lib.nixosSystem {
    #       inherit system;
    #       inherit ((getSystem system).allModuleArgs) pkgs;
    #       modules = [ ];
    #     };

    _module.args = {
      inherit pkgs;
    };
    packages = packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ../packages;
    };
    overlayAttrs = config.packages;
  };
}
