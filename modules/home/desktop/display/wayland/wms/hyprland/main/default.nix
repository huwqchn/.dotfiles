{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) listOf enum;
  inherit (lib.modules) mkIf;
  inherit (lib.my) scanPaths;
  inherit (config.my) desktop;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  isWayland = config.my.desktop.type == "wayland" && isLinux;
  isHyprland = desktop.environment == "hyprland" && isWayland;
  cfg = desktop.hyprland;
in {
  imports = scanPaths ./.;

  options.my.desktop.hyprland = {
    enable =
      mkEnableOption "Enable Hyprland"
      // {
        default = desktop.enable && isHyprland;
      };
    plugins = {
      enable = mkEnableOption "Enable Hyprland plugins";
      list = mkOption {
        default = [
          "hyprfocus"
          "hyprsplit"
          "hyprexpo"
          "hyprspace"
          "hyprgrass"
          "hypr-dynamic-cursors"
        ];
        type = listOf enum [
          "hy3"
          "hyprfocus"
          "hyprsplit"
          "hyprspace"
          "hyprexpo"
          "hyprbars"
          "hyprgrass"
          "hyprtrails"
          "hyprscroller"
          "borders-plus-plus"
          "csgo-vulkan-fix"
          "hypr-dynamic-cursors"
          "hyprwinwrap"
        ];
        description = "List of Hyprland plugins to enable";
      };
    };
  };

  config = mkIf cfg.enable {
    # enable hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      # NOTE: we use uwsm start hyprland, not manual ssystemd
      systemd.enable = false;
      # systemd = {
      #   enable = true;
      #   variables = ["--all"];
      #   extraCommands = [
      #     "systemctl --user stop graphical-session.target"
      #     "systemctl --user start hyprland-session.target"
      #   ];
      # };
    };

    # make stuff work on wayland
    # home.sessionVariables = {
    #   QT_QPA_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   XDG_SESSION_TYPE = "wayland";
    # };
  };
}
