{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem = {
    lib,
    config,
    pkgs,
    ...
  }: let
    inherit (lib.filesystem) packagesFromDirectoryRecursive;
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
    # more details see https://discourse.nixos.org/t/flake-parts-overlays-not-working/50435/10

    packages = packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ../pkgs;
    };
    overlayAttrs = config.packages;
  };
}
