{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.gx;
in {
  options.my.neovim.lazyvim.gx = {
    enable = mkEnableOption "gx browse";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      gx-nvim
    ];

    xdg.configFile = mkMerge [
      (sourceLua config "ui/gx.lua")
    ];
  };
}
