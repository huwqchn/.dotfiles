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
  inherit (builtins) readFile;
in {
  config = mkIf cfg.enable {
    programs.fish.interactiveShellInit = readFile "${src}/extras/fish/${themeName}.fish";
  };
}
