{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my.themes) wallpaper;
  cfg = config.my.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = ["${wallpaper}"];
        wallpaper = [", ${wallpaper}"];
      };
    };
  };
}
