{
  lib,
  config,
  ...
}: let
  #FIXME: this is a hack to get the background image to work
  #but it not works now, or use swww instead?
  background = "~/.config/background";
  cfg = config.my.desktop;
  inherit (lib.modules) mkIf;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable) {
    services.hyprpaper = {
      enable = false;

      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = [background];
        wallpaper = [", ${background}"];
      };
    };
  };
}
