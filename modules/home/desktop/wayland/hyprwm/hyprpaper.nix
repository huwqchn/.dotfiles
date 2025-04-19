{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        # NOTE: this is managed by stylix
        # preload = [background];
        # wallpaper = [", ${background}"];
      };
    };
  };
}
