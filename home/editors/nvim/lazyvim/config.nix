{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.my.neovim.lazyvim.config;
in {
  options.my.neovim.lazyvim.custom = {
    enable = mkEnableOption "LazyVim custom settings";
  };

  config = lib.mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.surround";
        path = mini-nvim;
      }
    ];

    xdg.configFile = {
      "nvim/lua/config".source = lib.my.relativeToConfig "nvim/lua/config";
      "nvim/lua/util".source = lib.my.relativeToConfig "nvim/lua/util";
    };
  };
}
