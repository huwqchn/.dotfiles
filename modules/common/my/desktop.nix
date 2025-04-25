{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum nullOr str;
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;
  inherit (lib.meta) getExe;
  inherit (config) my;
in {
  options.my.desktop = {
    enable =
      mkEnableOption "Desktop"
      // {
        default = true;
      };

    # TODO: i3 and bspwm are not supported yet
    # TODO: sway is not supported yet
    # TODO: should support niri, that's supper cool
    # TODO: should support cosmic desktop environment
    name = mkOption {
      type = nullOr (enum ["i3" "bspwm" "awesome" "niri" "sway" "hyprland" "aerospace"]);
      default =
        if !my.desktop.enable
        then null
        else if isLinux
        then "hyprland"
        else "aerospace";
      description = "The default desktop environment";
    };

    type = mkOption {
      type = nullOr (enum ["wayland" "xorg" "darwin"]);
      default =
        if !my.desktop.enable
        then null
        else if isLinux
        then "wayland"
        else "darwin";
      description = "The desktop environment type to use";
    };

    exec = mkOption {
      type = str;
      default = getExe (builtins.getAttr my.desktop.name pkgs);
      description = ''
        The command to use for logging in. This is used by the
        `my.desktop.exec` module to determine which command to run.
      '';
    };

    enableInputMethod =
      mkEnableOption "fcitx5"
      // {
        default = my.desktop.enable;
      };
  };
  config.assertions = [
    {
      assertion = my.desktop.type != null -> my.desktop.enable;
      message = "You can't use desktop.type without desktop.enable";
    }
    {
      assertion = my.desktop.enable -> my.desktop.type != null;
      message = "You can't use desktop.enable without desktop.type";
    }
    {
      assertion = my.desktop.name == "i3" -> my.desktop.type == "xorg";
      message = "You can't use i3 desktop environment without xorg";
    }
    {
      assertion = my.desktop.name == "bspwm" -> my.desktop.type == "xorg";
      message = "You can't use bspwm desktop environment without xorg";
    }
    {
      assertion = my.desktop.name == "hyprland" -> my.desktop.type == "wayland";
      message = "You can't use hyprland desktop environment without wayland";
    }
    {
      assertion = my.desktop.name == "sway" -> my.desktop.type == "wayland";
      message = "You can't use sway desktop environment without wayland";
    }
    {
      assertion = my.desktop.type == "xorg" -> isLinux;
      message = "You can't use xorg on non-linux system";
    }
    {
      assertion = my.desktop.type == "wayland" -> isLinux;
      message = "You can't use wayland on non-linux system";
    }
    {
      assertion = my.desktop.type == "darwin" -> isDarwin;
      message = "You can't use darwin desktop environment on non-darwin system";
    }
    {
      assertion = my.desktop.name == "aerospace" -> my.desktop.type == "darwin";
      message = "You can't use aerospace desktop environment without darwin";
    }
  ];
}
