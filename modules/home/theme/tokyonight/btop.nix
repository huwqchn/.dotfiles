{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.theme.tokyonight;

  inherit (config.my.theme.general) transparent;
in {
  config = mkIf cfg.enable {
    programs.btop.settings = {
      color_theme = "tokyo-night";
      theme_background = transparent; # make it transparent
    };
  };
}
