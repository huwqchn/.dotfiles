{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) isWayland;

  enable = config.my.desktop.launcher == "hyprlauncher" && isWayland config;
in {
  config = mkIf enable {
    home.packages = [pkgs.hyprlauncher];
  };
}
