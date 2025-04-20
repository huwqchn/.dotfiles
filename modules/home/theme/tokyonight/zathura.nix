{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  src = pkgs.vimPlugins.tokyonight-nvim;
  cfg = config.my.theme.tokyonight;
  inherit (config.my.theme.colorscheme) slug;
in {
  config = mkIf cfg.enable {
    programs.zathura.extraConfig = "include ${src + "/extras/zathura/" + slug + ".zathurarc"}";
  };
}
