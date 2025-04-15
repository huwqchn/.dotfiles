{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.lists) optional;
  isWayland = config.my.desktop.type == "wayland";
  cfg = config.my.programs.wine;
in {
  options.my.programs.wine = lib.my.mkProgram pkgs "wine" {
    package.default =
      if isWayland config
      then pkgs.wineWowPackages.waylandFull
      else pkgs.wineWowPackages.stableFull;
  };

  # determine which version of wine to use
  config.environment.systemPackages = optional cfg.enable cfg.package;
}
