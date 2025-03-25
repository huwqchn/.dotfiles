{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.my) mkProgram;
  inherit (lib.lists) optional;
  isWayland = config.my.desktop.wayland.enable;
  cfg = config.my.programs.wine;
in {
  options.my.programs.wine = mkProgram pkgs "wine" {
    package.default =
      if isWayland config
      then pkgs.wineWowPackages.waylandFull
      else pkgs.wineWowPackages.stableFull;
  };

  # determine which version of wine to use
  environment.systemPackages = optional cfg.enable cfg.package;
}
