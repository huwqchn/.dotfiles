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
    programs.alacritty.settings = {
      import = ["${src}/extras/alacritty/${slug}.yml"];
    };
  };
}
