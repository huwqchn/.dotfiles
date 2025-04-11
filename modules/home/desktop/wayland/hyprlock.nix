{
  pkgs,
  lib,
  config,
  ...
}: let
  package = pkgs.hyprlock;
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable && pkgs.stdenv.isLinux) {
    programs.hyprlock = {
      enable = true;
      inherit package;

      settings = {
        general = {disable_loading_bar = true;};

        background = [
          {
            monitor = "";
            path = "./tokyonight.png";
            blur_passes = 3;
            blur_size = 7;
            noise = 1.17e-2;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "300, 50";
            outline_thickness = 2;
            outer_color = "rgba(0, 0, 0, 0)";
            inner_color = "rgba(0, 0, 0, 0.5)";
            font_color = "rgb(200, 200, 200)";
            fade_on_empty = false;
            placeholder_text = ''<i><span foreground="##cdd6f4">Password...</span></i>'';

            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;

            hide_input = false;
            position = "0, -120";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%-H:%M")"'';
            font_size = 120;
            font_family = "Maple Mono Bold";
            position = "0, 150";
            halign = "center";
            valign = "top";
          }
          {
            moitor = "";
            text = "Hi there, $USER!";
            font_size = 25;
            font_family = "Maple Mono";
            position = "0, 50";
            valign = "center";
            halign = "center";
          }
        ];
      };
    };
  };
}
