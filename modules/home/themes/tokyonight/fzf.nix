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
    programs.fzf.colors = with palette; {
      "bg+" = bg_visual;
      "bg" = bg_dark;
      "border" = border_highlight;
      "fg" = fg;
      "gutter" = bg_dark;
      "header" = orange;
      "hl+" = blue1;
      "hl" = blue1;
      "info" = dark3;
      "marker" = magenta2;
      "pointer" = magenta2;
      "prompt" = blue1;
      "query" = fg;
      "scrollbar" = border_highlight;
      "separator" = orange;
      "spinner" = magenta2;
    };
  };
}
