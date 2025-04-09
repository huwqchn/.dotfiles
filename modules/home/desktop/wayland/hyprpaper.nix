{
  lib,
  config,
  pkgs,
  ...
}: let
  background = "~/.config/background";
  cfg = config.my.desktop;
  inherit (lib) mkIf;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable && pkgs.stdenv.isLinux) {
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
