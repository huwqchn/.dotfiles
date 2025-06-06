{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.yazi;
in {
  options.my.neovim.lazyvim.yazi = {
    enable = mkEnableOption "yazi explorer";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      yazi-nvim
    ];

    xdg.configFile = mkMerge [
      (sourceLua "editor/yazi.lua")
    ];
  };
}
