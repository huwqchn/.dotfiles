{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf importTOML;
  src = pkgs.vimPlugins.tokyonight-nvim;
  cfg = config.my.theme.tokyonight;
  themeName = "tokyonight_${cfg.style}";
in {
  config = mkIf cfg.enable {
    services.dunst.settings = importTOML "${src}/extras/dunst/${themeName}.dunstrc";
  };
}
