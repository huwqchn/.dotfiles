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
  enable = cfg.enable && config.my.zellij.enable;
in {
  # TODO: It's not working as my expectation
  config = mkIf enable {
    programs.zellij.settings = {
      theme = slug;
      theme_dir = "${src}/extras/zellij";
    };
  };
}
