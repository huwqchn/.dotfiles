{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;

  inherit (config.my) desktop;
in {
  config = mkIf (desktop.enable && desktop.wayland.enable && desktop.default == "hyprland") {
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
