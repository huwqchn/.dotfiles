{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.obsidian;
in {
  options.my.neovim.lazyvim.obsidian = {
    enable = mkEnableOption "Obsidian plugin for LazyVim";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins; [
        obsidian-nvim
      ];
    };
    xdg.configFile = mkMerge [
      (sourceLua config "util/obsidian.lua")
    ];
  };
}
