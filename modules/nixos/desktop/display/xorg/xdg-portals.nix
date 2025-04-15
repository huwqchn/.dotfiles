{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
  isXorg = cfg.type == "xorg";
in {
  config = mkIf (cfg.enable && isXorg) {
    xdg.portal = {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
