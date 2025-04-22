{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.strings) optionalString;
  inherit (config.my.desktop) fcitx5;
  cfg = config.my.desktop.hyprland;
  fcitx5' = lib.getExe' pkgs.fcitx5 "fcitx5";
  wl-clip-persist' = lib.getExe pkgs.wl-clip-persist;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      exec = [
        # "gsettings set ${gnome-schema} gtk-theme $system_theme"
        # "gsettings set ${gnome-schema} icon-theme $icon_theme"
        # "gsettings set ${gnome-schema} cursor-theme $cursor_theme"
        # "gsettings set org.gnome.desktop.interface text-scaling-factor $text_scale"
        # "gsettings set org.gnome.desktop.interface cursor-size $cursor_size"
        # "hyprshade auto"
      ];

      exec-once = [
        # "systemctl --user import-environment"
        # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XAUTHORITY"
        # "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        # "gnome-keyring-daemon --start"
        # "ags"
        # "easyeffects --gapplication-service"
        # "safeeyes -e"
        "${wl-clip-persist'} --clipboard regular"
        "${wl-clip-persist'} --watch cliphist store"
        (optionalString fcitx5.enable fcitx5')
        # "xhost si:localuser:root"
      ];
    };
  };
}
