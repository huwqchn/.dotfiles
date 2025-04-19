# FIXME: Hyprland config has so many errors need fix up
{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (config.my) desktop;
  isHyprland = desktop.environment == "Hyprland";
  cfg = desktop.hyprland;
in {
  imports = [./binds.nix ./rules.nix ./settings.nix];

  options.my.desktop.hyprland = {
    enable =
      mkEnableOption "Enable Hyprland"
      // {
        default = desktop.enable && desktop.type == "wayland" && isHyprland;
      };
  };

  # TODO: monitors config
  config = mkIf cfg.enable {
    # enable hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      plugins = with pkgs.hyprlandPlugins; [
        hyprbars
        hyprexpo
      ];

      systemd = {
        enable = true;
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };

    # make stuff work on wayland
    # home.sessionVariables = {
    #   QT_QPA_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   XDG_SESSION_TYPE = "wayland";
    # };
  };
}
