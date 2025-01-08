{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.mini-surround;
in {
  options.my.neovim.lazyvim.mini-surroulnd = {
    enable = mkEnableOption "Fast and feature-rich surround actions";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.surround";
        path = mini-nvim;
      }
    ];

    xdg.configFile."nvim/lua/plugins/mini-surround.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/coding/mini-surround.lua";
  };
}
