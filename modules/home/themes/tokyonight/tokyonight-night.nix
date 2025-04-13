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
  config = mkIf (cfg.enable && cfg.style == "night") {
    programs = {
      starship.settings = {
        palette = "tokyonight-night";
        palettes.tokyonight-night = {
          bg = "#1a1b26";
          fg = "#c0caf5";
          gray = "#292e42";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };
      };
      tmux.plugins = with pkgs.tmuxPlugins; [
        {
          plugin = mode-indicator;
          extraConfig = lib.mkBefore ''
            color_background='#1a1b26'
            color_foreground='#c0caf5'
            color_gray='#292e42'
            color_red='#ff899d'
            color_yellow='#faba4a'
            color_green='#9fe044'
            color_blue='#7aa2f7'
            color_cyan='#41a6b5'
          '';
        }
      ];
      fzf.colors = {
        "bg+" = "#283457";
        "bg" = "#16161e";
        "border" = "#27a1b9";
        "fg" = "#c0caf5";
        "gutter" = "#16161e";
        "header" = "#ff9e64";
        "hl+" = "#2ac3de";
        "hl" = "#2ac3de";
        "info" = "#545c7e";
        "marker" = "#ff007c";
        "pointer" = "#ff007c";
        "prompt" = "#2ac3de";
        "query" = "#c0caf5";
        "scrollbar" = "#27a1b9";
        "separator" = "#ff9e64";
        "spinner" = "#ff007c";
      };
      lazygit.settings.gui.theme = {
        activeBorderColor = ["#ff9e64" "bold"];
        inactiveBorderColor = ["#27a1b9"];
        searchingActiveBorderColor = ["#ff9e64" "bold"];
        optionsTextColor = ["#7aa2f7"];
        selectedLineBgColor = ["#283457"];
        cherryPickedCommitFgColor = ["#7aa2f7"];
        cherryPickedCommitBgColor = ["#bb9af7"];
        markedBaseCommitFgColor = ["#7aa2f7"];
        markedBaseCommitBgColor = ["#e0af68"];
        unstagedChangesColor = ["#db4b4b"];
        defaultFgColor = ["#c0caf5"];
      };
    };
  };
}
