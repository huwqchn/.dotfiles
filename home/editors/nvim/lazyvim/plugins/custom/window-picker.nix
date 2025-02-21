{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.window-picker;
in {
  options.my.neovim.lazyvim.window-picker = {
    enable = mkEnableOption "window picker";
  };

  config = mkIf cfg.enable {
    my.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      nvim-window-picker
    ];

    xdg.configFile."nvim/lua/plugins/window-picker.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/ui/window-picker.lua";
  };
}
