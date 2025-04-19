# FIXME: Remove hardcoded colors, use stylix instead
{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkBefore;
  cfg = config.my.themes.tokyonight;
in {
  config = mkIf (cfg.enable && cfg.style == "day") {
    programs = {
      spotify-player = {
        settings.theme = "tokyonight-day";
        themes = [
          {
            name = "tokyonight-day";
            palette = {
              background = "#e1e2e7";
              foreground = "#3760bf";
              black = "#a1a6c5";
              red = "#f52a65";
              green = "#587539";
              yellow = "#8c6c3e";
              blue = "#2e7de9";
              magenta = "#9854f1";
              cyan = "#007197";
              white = "#d0d5e3";
              bright_black = "#e1e2e7";
              bright_red = "#c64343";
              bright_green = "#387068";
              bright_yellow = "#b15c00";
              bright_blue = "#188092";
              bright_magenta = "#d20065";
              bright_cyan = "#006a83";
              bright_white = "#3760bf";
            };
            component_style = {
              block_title = {
                fg = "BrightGreen";
                modifiers = ["Italic" "Bold"];
              };
              like = {
                fg = "Red";
                modifiers = ["Bold"];
              };
              playback_track = {
                fg = "BrightMagenta";
                modifiers = ["Italic"];
              };
              playback_album = {
                fg = "BrightRed";
                modifiers = ["Italic"];
              };
              playback_artists = {
                fg = "BrightCyan";
                modifiers = [];
              };
              playback_metadata = {
                fg = "BrightBlue";
                modifiers = [];
              };
              playback_progress_bar = {
                fg = "BrightGreen";
                modifiers = ["Italic"];
              };
              current_playing = {
                fg = "Red";
                modifiers = ["Bold" "Italic"];
              };
              playlist_desc = {
                fg = "White";
                modifiers = ["Italic"];
              };
              page_desc = {
                fg = "Magenta";
                modifiers = ["Bold" "Italic"];
              };
              table_header = {
                fg = "Blue";
                modifiers = ["Bold"];
              };
              border = {fg = "BrightYellow";};
              selection = {
                fg = "Red";
                modifiers = ["Bold" "Reversed"];
              };
              secondary_row = {bg = "BrightBlack";};
            };
          }
        ];
      };

      starship.settings = {
        palette = "tokyonight-day";
        palettes.tokyonight-day = {
          bg = "#e1e2e7";
          fg = "#3760bf";
          gray = "#b4b5b9";
          red = "#f52a65";
          green = "#587539";
          yellow = "#8c6c3e";
          blue = "#2e7de9";
          magenta = "#9854f1";
          cyan = "#007197";
          white = "#6172b0";
        };
      };
      tmux.plugins = with pkgs.tmuxPlugins; [
        {
          plugin = mode-indicator;
          extraConfig = mkBefore ''
            color_background='#e1e2e7'
            color_foreground='#3760bf'
            color_gray='#b4b5b9'
            color_red='#f52a65'
            color_yellow='#a27629'
            color_green='#587539'
            color_blue='#2e7de9'
            color_cyan='#4fd6be'
          '';
        }
      ];
      fzf.colors = {
        "bg+" = "#b7c1e3";
        "bg" = "#d0d5e3";
        "border" = "#4094a3";
        "fg" = "#3760bf";
        "gutter" = "#d0d5e3";
        "header" = "#b15c00";
        "hl+" = "#188092";
        "hl" = "#188092";
        "info" = "#8990b3";
        "marker" = "#d20065";
        "pointer" = "#d20065";
        "prompt" = "#188092";
        "query" = "#3760bf";
        "scrollbar" = "#4094a3";
        "separator" = "#b15c00";
        "spinner" = "#d20065";
      };
      lazygit.settings.gui.theme = {
        activeBorderColor = ["#b15c00" "bold"];
        inactiveBorderColor = ["#2496ac"];
        searchingActiveBorderColor = ["#b15c00" "bold"];
        optionsTextColor = ["#2e7de9"];
        selectedLineBgColor = ["#b6bfe2"];
        cherryPickedCommitFgColor = ["#2e7de9"];
        cherryPickedCommitBgColor = ["#9854f1"];
        markedBaseCommitFgColor = ["#2e7de9"];
        markedBaseCommitBgColor = ["#8c6c3e"];
        unstagedChangesColor = ["#c64343"];
        defaultFgColor = ["#3760bf"];
      };
    };
  };
}
