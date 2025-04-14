{
  lib,
  config,
  pkgs,
  ...
}: let
  #FIXME: this is a hack to get the background image to work
  #but it not works now, or use swww instead?
  background = "~/.config/background";
  cfg = config.my.desktop;
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable && isLinux) {
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
