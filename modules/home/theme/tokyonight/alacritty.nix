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
    programs.alacritty.settings = {
      import = ["${src}/extras/alacritty/${themeName}.yml"];
    };
  };
}
