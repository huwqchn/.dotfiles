{
  lib,
  config,
  ...
}: let
  cfg = config.my.desktop;
  inherit (lib.modules) mkIf;
  isWayland = cfg.type == "wayland";
in {
  config = mkIf (cfg.enable && isWayland) {
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
