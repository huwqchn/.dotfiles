{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  src = pkgs.vimPlugins.tokyonight-nvim;
  cfg = config.my.theme.tokyonight;
  themeName = "tokyonight_${cfg.style}";
in {
  config = mkIf cfg.enable {
    programs.bat = {
      config.theme = themeName;
      themes = {
        "${themeName}" = {
          inherit src;
          file = "extras/sublime/${themeName}.tmTheme";
        };
      };
    };
  };
}
