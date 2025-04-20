{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.themes.tokyonight;
  inherit (config.my.themes.colorscheme) palette;
in {
  config = mkIf cfg.enable {
    programs.lazygit.settings.gui.theme = with palette; {
      activeBorderColor = [orange "bold"];
      inactiveBorderColor = [border_highlight];
      searchingActiveBorderColor = [orange "bold"];
      optionsTextColor = [blue];
      selectedLineBgColor = [bg_visual];
      cherryPickedCommitFgColor = [blue];
      cherryPickedCommitBgColor = [magenta];
      markedBaseCommitFgColor = [blue];
      markedBaseCommitBgColor = [yellow];
      unstagedChangesColor = [red1];
      defaultFgColor = [fg];
    };
  };
}
