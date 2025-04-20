{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  src = pkgs.vimPlugins.tokyonight-nvim;
  cfg = config.my.themes.tokyonight;
  themeName = "tokyonight_${cfg.style}";
in {
  config = mkIf cfg.enable {
    programs.kitty.extraConfig = ''
      include ${src}/extras/kitty/${themeName}.conf
    '';
  };
}
