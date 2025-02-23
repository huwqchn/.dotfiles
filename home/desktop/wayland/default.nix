{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.my.scanPaths ./.;

  options.my.desktop.wayland = {enable = mkEnableOption "desktop.wayland";};
}
