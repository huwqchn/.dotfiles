{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe';
  inherit (lib.my) toggle;
  inherit (config.home) username;
  inherit (pkgs.stdenv.platform) isLinux;
  isWayland = config.my.desktop.type == "wayland" && isLinux;
  enable = config.my.desktop.powermenu == "wlogout" && isWayland;
  loginctl' = getExe' pkgs.systemd "loginctl";
  systemctl' = getExe' pkgs.systemd "systemctl";
  wlogout' = toggle pkgs "wlogout";
in {
  config = mkIf enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        # powermenu
        "$mod, Escape, exec, ${wlogout'} -p layer-shell"
      ];
    };
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = ''${loginctl'} lock-session'';
          text = "lock (l)";
          keybind = "l";
        }
        {
          label = "suspend";
          action = ''${systemctl'} suspend'';
          text = "suspend (z)";
          keybind = "z";
        }
        {
          label = "hibernate";
          action = ''${systemctl'} hibernate'';
          text = "hibernate (h)";
          keybind = "h";
        }
        {
          label = "logout";
          action = ''${loginctl'} terminate-user ${username}'';
          text = "logout (e)";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = ''${systemctl'} poweroff'';
          text = "shutdown (s)";
          keybind = "s";
        }
        {
          label = "reboot";
          action = ''${systemctl'} reboot'';
          text = "reboot (r)";
          kebind = "r";
        }
      ];
    };
  };
}
