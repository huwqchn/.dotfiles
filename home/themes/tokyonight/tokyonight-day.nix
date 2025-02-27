{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.tokyonight;
in {
  config = mkIf (cfg.enable && cfg.style == "day") {
    programs = {
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
