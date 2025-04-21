{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkAfter;
  cfg = config.my.desktop.hyprland;
in {
  options.my.desktop.hyprland.switch = {
    enable =
      mkEnableOption "hyprswitch"
      // {
        default = cfg.enable;
      };
  };

  config = mkIf cfg.switch.enable {
    home.packages = with pkgs; [
      hyprswitch
    ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "hyprswitch init --show-title --size-factor 5.5 --workspaces-per-row 5 &"
      ];
      bind = mkAfter [
        # Switcher
        "ALT, tab, exec, hyprswitch gui --mod-key ALT --key tab --close mod-key-release --reverse-key=mod=SHIFT --max-switch-offset 9 -m && hyprswitch dispatch"
        "ALT SHIFT, tab, exec, hyprswitch gui --mod-key ALT --key tab --close mod-key-release --reverse-key=mod=SHIFT --max-switch-offset 9 -m && hyprswitch dispatch -r"
      ];
    };

    xdg.configFile = {
      "hyprswitch/style.css".source = ./assets/hyprswitch.css;
    };
  };
}
