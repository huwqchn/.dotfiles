{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.meta) getExe;
  cfg = config.my.desktop;
  isHpyrland = cfg.environment == "hyprland";
  uwsm' = getExe pkgs.uwsm;
in {
  config = mkIf (cfg.enable && isHpyrland) {
    services.displayManager.defaultSession = "hyprland-uwsm";

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    my.greetd.login = "${uwsm'} start hyprland-uwsm.desktop";

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];

      # xdg-desktop-wlr (this section) is no longer needed, xdg-desktop-portal-hyprland
      # will (and should) override this one
      wlr.enable = mkForce false;
    };
  };
}
