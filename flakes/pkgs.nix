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
