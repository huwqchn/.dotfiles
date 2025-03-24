{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
  perSystem = {
    lib,
    pkgs,
    config,
    ...
  }: let
    inherit (lib.filesystem) packagesFromDirectoryRecursive;
  in {
    packages = packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ../packages;
    };

    overlayAttrs = {
      my = config.packages;
    };
  };
}
