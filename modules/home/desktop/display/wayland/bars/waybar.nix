{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) isWayland;

  enable = config.my.desktop.bar == "waybar" && isWayland config;
in {
  config = mkIf enable {
    programs.waybar = {
      enable = true;
    };
  };
}
