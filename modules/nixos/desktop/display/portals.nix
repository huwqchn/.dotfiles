{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkForce;
  cfg = config.my.desktop;
in {
  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
      wlr = {
        enable = mkForce cfg.wayland.enable;
        settings = {
          screencast = {
            max_fps = 60;
            chooser_type = "simple";
            chooser_cmd = "${getExe pkgs.slurp} -f %o -or";
          };
        };
      };
    };
  };
}
