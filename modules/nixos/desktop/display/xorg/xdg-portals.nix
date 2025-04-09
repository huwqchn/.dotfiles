{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.xorg.enable) {
    xdg.portal = {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
