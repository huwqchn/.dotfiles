{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.my) sourceLua;
  inherit (lib.modules) mkIf mkMerge;
  cfg = config.my.neovim.lazyvim.window-picker;
in {
  options.my.neovim.lazyvim.window-picker = {
    enable = mkEnableOption "window picker";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      nvim-window-picker
    ];

    xdg.configFile = mkMerge [
      (sourceLua config "ui/window-picker.lua")
    ];
  };
}
