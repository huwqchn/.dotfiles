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
  config = mkIf (cfg.picker == "telescope") {
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins; [
        telescope-nvim
        telescope-undo-nvim
        scope-nvim
      ];

      excludePlugins = with pkgs.vimPlugins; [
        fzf-lua
      ];
    };

    xdg.configFile = mkMerge [
      (sourceLua config "editor/telescope.lua")
    ];
  };
}
