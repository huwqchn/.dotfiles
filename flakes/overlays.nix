# Credit to khaneliman
# https://github.com/khaneliman/khanelinix/blob/e971d9750b5e61e1f4ae18d63578bf169dd7ce68/flake/overlays.nix
{
  inputs,
  lib,
  ...
}: let
  overlaysPath = ../overlays;
  dynamicOverlaysSet =
    if builtins.pathExists overlaysPath
    then let
      overlayDirs = builtins.attrNames (builtins.readDir overlaysPath);
    in
      lib.genAttrs overlayDirs (
        name: let
          overlayPath = overlaysPath + "/${name}";
          overlayFn = import overlayPath;
        in
          if lib.isFunction overlayFn
          then overlayFn {inherit inputs;}
          else overlayFn
      )
    else {};

  myPackagesOverlay = final: prev: let
    directory = ../packages;
    packageFunctions = prev.lib.filesystem.packagesFromDirectoryRecursive {
      inherit directory;
      callPackage = file: _args: import file;
    };
  in {
    my = prev.lib.fix (
      self:
        prev.lib.mapAttrs (
          _name: func: final.callPackage func (self // {inherit inputs;})
        )
        packageFunctions
    );
  };

  allOverlays = (lib.attrValues dynamicOverlaysSet) ++ [myPackagesOverlay];
in {
  flake = {
    overlays =
      dynamicOverlaysSet
      // {
        default = myPackagesOverlay;
        my = myPackagesOverlay;
      };

    perSystem = {
      config,
      pkgs,
      ...
    }: {
      pkgs = pkgs.extend (lib.composeManyExtensions allOverlays);

      packages = config.pkgs.my;
    };
  };
}
