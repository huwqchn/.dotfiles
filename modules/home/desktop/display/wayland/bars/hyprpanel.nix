{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.platform) isLinux;
  isWayland = config.my.desktop.type == "Wayland" && isLinux;
  enable = config.my.desktop.bar == "hyprpanel" && isWayland;
in {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  config = mkIf enable {
    programs.hyprpanel = {
      enable = true;
      hyprland.enable = config.my.desktop.hyprland.enable;
      overwrite.enable = true;
      settings = {
        scalingPriority = "hyprland";

        inherit (config.my) terminal;
        tear = false;
        layout = {
          "bar.layouts" = {
            "0" = {
              left = ["dashboard" "workspaces" "media"];
              middle = ["weather" "clock" "notifications"];
              right = ["volume" "bluetooth" "network" "battery" "systray" "power"];
            };
          };
        };

        bar = {
          launcher.autoDetectIcon = true;
          clock.format = "%I:%M";
          media.show_active_only = true;
          notifications.hideCountWhenZero = true;
          network = {
            label = true;
            truncation = true;
            truncation_size = 10;
          };
          workspaces = {
            show_icons = false;
            showApplicationIcons = true;
            numbered_active_indicator = "highlight";
            workspaces = config.my.desktop.general.workspace.number;
          };
        };

        theme = {
          matugen = false;
          bar = {
            transparent = false;
            floating = true;
            layer = "top";
            location = "top";

            margin_bottom = "0";
            margin_sides = "20px";
            margin_top = "20px";

            border_radius = "10px";

            border = {
              location = "full";
              width = "2px";
            };

            buttons = {
              enableBorders = false;
              monochrome = false;
              style = "default";
            };
          };

          font = {
            name = "CaskaydiaCove NF";
            size = "16px";
          };
        };

        menus = {
          transition = "crossfade";
          transitionTime = 200;
          clock = {
            time = {
              military = false;
              hideSeconds = true;
            };

            weather = {
              enabled = true;
              key = "deffd85bfc6d8a3573bc96b9360d72f3";
              unit = "metric"; # Available options : 'metric' or 'imperial'
              location = "Shanghai";
            };
          };

          dashboard = {
            directories.enabled = false;
            stats.enable_gpu = true;
          };

          media = {
            displayTime = true;
            displayTimeTooltip = true;
            noMediaText = "-";
          };

          power = {
            confirmation = true;
            showLabel = true;
            logout = "hyprctl dispatch exit";
            reboot = "systemctl reboot";
            shutdown = "systemctl poweroff";
            sleep = "systemctl suspend";
          };

          volume.raiseMaximumVolume = false;
        };
        notifications = {
          active_monitor = true;
          cache_actions = true;
          clearDelay = 50;
          displayedTotal = 5;
          showActionsOnHover = true;
          timeout = 5000;
        };
        wallpaper = {
          enable = false;
          pywal = false;
          image = "";
        };
      };
    };
  };
}
