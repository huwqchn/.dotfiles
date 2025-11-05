{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.my) scanPaths ldTernary;
  inherit (lib.options) mkOption;
  inherit (lib.types) int enum nullOr;
  inherit (config.my) desktop;
in {
  imports = scanPaths ./.;

  options.my.desktop = {
    bar = mkOption {
      type = nullOr (enum ["hyprpanel"]);
      default =
        ldTernary pkgs
        (
          if desktop.enable
          then "hyprpanel"
          else null
        )
        null;
      description = "The Bar to use";
    };
    lock = mkOption {
      type = nullOr (enum ["hyprlock"]);
      default =
        ldTernary pkgs
        (
          if desktop.enable
          then "hyprlock"
          else null
        )
        null;
      description = "The lock screen to use";
    };
    wallEngine = mkOption {
      type = nullOr (enum ["hyprpaper"]);
      default =
        ldTernary pkgs
        (
          if desktop.enable
          then "hyprpaper"
          else null
        )
        null;
      description = "The wallpaper engine to use";
    };
    idle = mkOption {
      type = nullOr (enum ["hypridle"]);
      default =
        ldTernary pkgs
        (
          if desktop.enable
          then "hypridle"
          else null
        )
        null;
      description = "The idle screen to use";
    };
    launcher = mkOption {
      type = nullOr (enum []);
      default = null;
      description = "The launcher to use";
    };
    shot = mkOption {
      type = nullOr (enum ["hyprshot" "grimblast"]);
      default =
        ldTernary pkgs
        (
          if desktop.enable
          then "grimblast"
          else null
        )
        null;
      description = "The screenshot tool to use";
    };
    powermenu = mkOption {
      type = nullOr (enum ["hyprpanel" "wlogout"]);
      default =
        ldTernary pkgs
        (
          if desktop.enable
          then "wlogout"
          else null
        )
        null;
      description = "The powermenu to use";
    };
    notification = mkOption {
      type = nullOr (enum ["hyprpanel" "avizo"]);
      default =
        ldTernary pkgs
        (
          if desktop.enable
          then "hyprpanel"
          else null
        )
        null;
      description = "The notification daemon to use";
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
