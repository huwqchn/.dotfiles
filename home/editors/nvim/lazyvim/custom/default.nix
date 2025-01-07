{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.my.lazyvim.custom;
in {
  options.my.lazyvim.custom = {
    enable = mkEnableOption "LazyVim custom settings";
  };

  config = lib.mkIf cfg.enable {
    my.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.surround";
        path = mini-nvim;
      }
    ];

    xdg.configFile = {
      "nvim/lua/config".source = ./config;
      "nvim/lua/util".source = ./util;
    };
  };
}
