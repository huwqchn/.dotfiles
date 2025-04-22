{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    home.pointerCursor.hyprcursor.enable = true;
  };
}
