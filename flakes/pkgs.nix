{inputs, ...}: {
  perSystem = {
    lib,
    self',
    config,
    system,
    ...
  }: let
    inherit (lib.filesystem) packagesFromDirectoryRecursive;
    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowAliases = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
    };
  in {
    _module.args = {
      inherit pkgs;
      pkgs' = self'.packages;
    };
    packages = packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ../packages;
    };
  };
}
