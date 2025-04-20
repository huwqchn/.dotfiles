{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      animations = {
        enabled = true;
        first_launch_animation = true;

        # name, x0, y0, x1, y1
        # x0 and x1 are control animation speed
        # y0 and y1 are control animation duration
        bezier = [
          "overshot,0.13,0.99,0.29,1.1"
          "bounceback,0.1,1.4,0.2,1.0"
          "elastic,0.32,1.56,0.68,1.0"
          "jelly,0.34,1.56,0.64,0.8"
          "linear,0,0,1,1"

          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          # "snappy, 0.5, 0.93, 0, 1"
        ];
        animation = [
          "windows,1,6,jelly,popin 80%"
          "windowsMove,1,6,ovreshot,slide"
          "layer,1,10,bounceback,slide"
          "fadeIn,1,10,smoothIn"
          "fadeOut,1,10,smoothOut"
          "workspaces,1,8.8,overshot,slidefade"
          "border,1,5,linear"
          "borderangle,1,15,linear,once"
        ];
      };
    };
  };
}
