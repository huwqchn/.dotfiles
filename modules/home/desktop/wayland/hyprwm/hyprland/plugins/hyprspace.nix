{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) elem;
  inherit (config.my.desktop.hyprland) plugins;
  enable = plugins.enable && elem "hyprspace" plugins.list;
in {
  config = mkIf enable {
    wayland.windowManager.hyprland = {
      plugins = with pkgs.hyprlandPlugins; [hyprspace];

      settings = {
        bind = [
          "$mainMod, TAB, overview:toggle"
          "$mainMod SHIFT, TAB, overview:toggle, all"
        ];
        plugin.overview = {
          # layout
          gapsIn = 5;
          gapsOut = 5;
          panelHeight = 100;

          # behavior
          autoDrag = false;
          autoScroll = true;
          exitOnClick = true;
          switchOnDrop = true;
          exitOnSwitch = true;
          showNewWorkspace = true;
          centerAligned = true;
          hideTopLayers = true;
          hideOverlayLayers = true;
          drawActiveWorkspace = true;

          # TODO: theme
          # plugin:overview:panelColor
          # plugin:overview:panelBorderColor
          # plugin:overview:workspaceActiveBackground
          # plugin:overview:workspaceInactiveBackground
          # plugin:overview:workspaceActiveBorder
          # plugin:overview:workspaceInactiveBorder
          # plugin:overview:dragAlpha overrides the alpha of window when dragged in overview (0 - 1, 0 = transparent, 1 = opaque)
          # plugin:overview:disableBlur
        };
      };
    };
  };
}
