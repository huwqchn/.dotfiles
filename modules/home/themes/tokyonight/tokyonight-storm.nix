{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.tokyonight;
in {
  config = mkIf (cfg.enable && cfg.style == "storm") {
    programs = {
      starship.settings = {
        palette = "tokyonight-storm";
        palettes.tokyonight-storm = {
          bg = "#24283b";
          fg = "#c0caf5";
          gray = "#292e42";
          blue = "#7aa2f7";
          cyan = "#7dcfff";
          green = "#9ece6a";
          magenta = "#bb9af7";
          orange = "#ff9e64";
          red = "#f7768e";
          yellow = "#e0af68";
          white = "#a9b1d6";
        };
      };
      tmux.plugins = with pkgs.tmuxPlugins; [
        {
          plugin = mode-indicator;
          extraConfig = lib.mkBefore ''
            color_background='#24283b'
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
        "bg+" = "#2e3c64";
        "bg" = "#1f2335";
        "border" = "#29a4bd";
        "fg" = "#c0caf5";
        "gutter" = "#1f2335";
        "header" = "#ff9e64";
        "hl+" = "#2ac3de";
        "hl" = "#2ac3de";
        "info" = "#545c7e";
        "marker" = "#ff007c";
        "pointer" = "#ff007c";
        "prompt" = "#2ac3de";
        "query" = "#c0caf5";
        "scrollbar" = "#29a4bd";
        "separator" = "#ff9e64";
        "spinner" = "#ff007c";
      };
      lazygit.settings.gui.theme = {
        activeBorderColor = ["#ff9e64" "bold"];
        inactiveBorderColor = ["#29a4bd"];
        searchingActiveBorderColor = ["#ff9e64" "bold"];
        optionsTextColor = ["#7aa2f7"];
        selectedLineBgColor = ["#2e3c64"];
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
