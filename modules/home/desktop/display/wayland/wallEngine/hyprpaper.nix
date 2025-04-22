{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my.theme) wallpaper;
  enable = config.my.desktop.wallEngine == "hyprpaper";
in {
  config = mkIf enable {
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
