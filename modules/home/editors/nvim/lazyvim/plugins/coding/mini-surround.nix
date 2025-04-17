{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.mini-surround;
in {
  options.my.neovim.lazyvim.mini-surround = {
    enable = mkEnableOption "Fast and feature-rich surround actions";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.surround";
        path = mini-nvim;
      }
    ];

    xdg.configFile = mkMerge [
      (sourceLua "coding/mini-surround.lua")
    ];
  };
}
