{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim;
in {
  config = mkIf (cfg.picker == "fzf") {
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins; [
        fzf-lua
      ];
      excludePlugins = with pkgs.vimPlugins; [
        telescope-nvim
      ];
    };

    xdg.configFile = mkMerge [
      (sourceLua config "editor/fzf.lua")
    ];
  };
}
