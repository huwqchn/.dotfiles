{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.my.scanPaths ./.;

  options.my.desktop.wayland = {
    enable =
      mkEnableOption "desktop.wayland"
      // {
        default = config.my.desktop.enable;
      };
  };
}
