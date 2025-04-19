{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkAfter;
  inherit (lib.lists) elem;
  inherit (lib.my) mkHyprWorkspaces;
  inherit (config.my.desktop.hyprland) plugins;
  enable = plugins.enable && elem "hyprfocus" plugins.list;
  num_workspaces = config.my.desktop.general.workspace.number;
in {
  config = mkIf enable {
    wayland.windowManager.hyprland = {
      plugins = with pkgs.hyprlandPlugins; [hyprsplit];
      settings = {
        bind =
          mkAfter [
            "$mod, D, split:swapactiveworkspaces, current + 1"
            "$mod SHIFT, G, split:grabroguewindows"
          ]
          ++ (mkHyprWorkspaces
            ["split:workspace" "split:movetoworkspace" "split:movetoworkspacesilent"]
            num_workspaces);
        plugin.hyprsplit = {
          inherit num_workspaces;
          persistent_workspaces = true;
        };
      };
    };
  };
}
