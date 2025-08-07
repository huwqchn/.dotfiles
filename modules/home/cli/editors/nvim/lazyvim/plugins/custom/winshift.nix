{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.winshift;
in {
  options.my.neovim.lazyvim.winshift = {
    enable = mkEnableOption "window winshift";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [winshift-nvim];

    xdg.configFile = mkMerge [
      (sourceLua config "ui/winshift.lua")
    ];
  };
}
