{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my.theme) wallpaper;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  isWayland = config.my.desktop.type == "wayland" && isLinux;
  enable = config.my.desktop.wallEngine == "hyprpaper" && isWayland;
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
