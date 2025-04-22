{
  lib,
  config,
  ...
}: let
  inherit (lib.my) scanPaths;
  inherit (lib.options) mkOption;
  inherit (lib.types) int enum nullOr;
  inherit (config.my) desktop;
in {
  imports = scanPaths ./.;

  options.my.desktop = {
    bar = mkOption {
      type = nullOr (enum ["hyprpanel"]);
      default =
        if desktop.enable
        then "hyprpanel"
        else null;
      description = "The Bar to use";
    };
    lock = mkOption {
      type = nullOr (enum ["hyprlock"]);
      default =
        if desktop.enable
        then "hyprlock"
        else null;
      description = "The lock screen to use";
    };
    wallEngine = mkOption {
      type = nullOr (enum ["hyprpaper"]);
      default =
        if desktop.enable
        then "hyprpaper"
        else null;
      description = "The wallpaper engine to use";
    };
    idle = mkOption {
      type = nullOr (enum ["hypridle"]);
      default =
        if desktop.enable
        then "hypridle"
        else null;
      description = "The idle screen to use";
    };
    launcher = mkOption {
      type = nullOr (enum ["anyrun"]);
      default =
        if desktop.enable
        then "anyrun"
        else null;
      description = "The launcher to use";
    };
    shots = mkOption {
      type = nullOr (enum ["hyprshots"]);
      default =
        if desktop.enable
        then "hyprshots"
        else null;
      description = "The screenshot tool to use";
    };
    powermenu = mkOption {
      type = nullOr (enum ["wlogout"]);
      default =
        if desktop.enable
        then "wlogout"
        else null;
      description = "The powermenu to use";
    };
    general = {
      workspace = {
        number = mkOption {
          type = int;
          default = 10;
          description = "Number of workspaces";
        };
      };
      keybind = {
        modifier = mkOption {
          type = enum ["SUPER" "CTRL" "ALT"];
          default = "SUPER";
          description = "Modifier key for keybinds";
        };
      };
    };
  };
}
