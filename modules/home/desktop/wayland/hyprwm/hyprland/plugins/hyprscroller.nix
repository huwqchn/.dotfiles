{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) elem;
  inherit (config.my.desktop.hyprland) plugins;
  enable = plugins.enable && elem "hyprscroller" plugins.list;
in {
  config = mkIf enable {
    wayland.windowManager.hyprland = {
      plugins = with pkgs.hyprlandPlugins; [hyprscroller];
      settings = {
        general.layout = "scroller";
        bind = ["$mod SHIFT, S, scroller:toggleoverview, toggle"];
      };
    };
  };
}
