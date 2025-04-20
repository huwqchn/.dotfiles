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
    programs.git = {
      includes = [{path = "${src}/extras/delta/${themeName}.gitconfig";}];
      delta.options.features = themeName;
    };
  };
}
