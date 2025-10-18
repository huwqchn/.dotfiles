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
  config = mkIf enable {
    programs.zellij.settings = {
      theme = slug;
    };

    xdg.configFile."zellij/themes/${slug}.kdl".source = mkIf config.programs.zellij.enable "${src}/extras/zellij/${slug}.kdl";
  };
}
