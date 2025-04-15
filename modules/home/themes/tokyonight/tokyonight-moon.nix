# FIXME: Remove hardcoded colors, use stylix instead
{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.themes.tokyonight;
in {
  config = mkIf (cfg.enable && cfg.style == "moon") {
    programs = {
      spotify-player = {
        settings.theme = "tokyonight-moon";
        themes = [
          {
            name = "tokyonight-moon";
            palette = {
              background = "#1e2030";
              foreground = "#c8d3f5";
              black = "#444a73";
              red = "#ff757f";
              green = "#c3e88d";
              yellow = "#ffc777";
              blue = "#82aaff";
              magenta = "#c099ff";
              cyan = "#86e1fc";
              white = "#828bb8";
              bright_black = "#222436";
              bright_red = "#c53b53";
              bright_green = "#4fd6be";
              bright_yellow = "#ff966c";
              bright_blue = "#65bcff";
              bright_magenta = "#ff007c";
              bright_cyan = "#89ddff";
              bright_white = "#c8d3f5";
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
        palette = "tokyonight-moon";
        palettes.tokyonight-moon = {
          bg = "#1e2030";
          fg = "#c8d3f5";
          gray = "#2f334d";
          red = "#ff757f";
          green = "#c3e88d";
          yellow = "#ffc777";
          blue = "#82aaff";
          magenta = "#c099ff";
          cyan = "#86e1fc";
          white = "#828bb8";
        };
      };
      tmux.plugins = with pkgs.tmuxPlugins; [
        {
          plugin = mode-indicator;
          extraConfig = lib.mkBefore ''
            color_background='#1e2030'
            color_foreground='#c8d3f5'
            color_gray='#2f334d'
            color_red='#ff007c'
            color_yellow='#ffc777'
            color_green='#c7fb6d'
            color_blue='#82aaff'
            color_cyan='#4fd6be'
          '';
        }
      ];
      fzf.colors = {
        "bg+" = "#2d3f76";
        "bg" = "#1e2030";
        "border" = "#589ed7";
        "fg" = "#c8d3f5";
        "gutter" = "#1e2030";
        "header" = "#ff966c";
        "hl+" = "#65bcff";
        "hl" = "#65bcff";
        "info" = "#545c7e";
        "marker" = "#ff007c";
        "pointer" = "#ff007c";
        "prompt" = "#65bcff";
        "query" = "#c8d3f5";
        "scrollbar" = "#589ed7";
        "separator" = "#ff966c";
        "spinner" = "#ff007c";
      };
      lazygit.settings.gui.theme = {
        activeBorderColor = ["#ff966c" "bold"];
        inactiveBorderColor = ["#589ed7"];
        searchingActiveBorderColor = ["#ff966d" "bold"];
        optionsTextColor = ["#82aaff"];
        selectedLineBgColor = ["#2d3f76"];
        cherryPickedCommitFgColor = ["#82aaff"];
        cherryPickedCommitBgColor = ["#c099ff"];
        markedBaseCommitFgColor = ["#82aaff"];
        markedBaseCommitBgColor = ["#ffc777"];
        unstagedChangesColor = ["#c53b53"];
        defaultFgColor = ["#c8d3f5"];
      };
    };
  };
}
