{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.tokyonight;
in {
  config = mkIf (cfg.enable && cfg.style == "night") {
    programs = {
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
