{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.mini-files;
in {
  options.my.neovim.lazyvim.mini-files = {
    enable = mkEnableOption "Mini files explorer";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.files";
        path = mini-nvim;
      }
    ];

    xdg.configFile = mkMerge [
      (sourceLua config "editor/mini-files.lua")
    ];
  };
}
