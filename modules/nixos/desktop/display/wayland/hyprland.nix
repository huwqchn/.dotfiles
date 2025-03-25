{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (config.my) desktop;
in {
  config = mkIf (desktop.enable && desktop.default == "hyprland") {
    services.displayManager.sessionPackages = [pkgs.hyprland];
  };
}
