{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  cfg = config.my.desktop;
  isHpyrland = cfg.environment == "Hyprland";
in {
  config = mkIf (cfg.enable && isHpyrland == "Hyprland") {
    services.displayManager.sessionPackages = [pkgs.hyprland];
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
