{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.yazi;
in {
  options.my.neovim.lazyvim.yazi = {
    enable = mkEnableOption "yazi explorer";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      yazi-nvim
    ];

    xdg.configFile."nvim/lua/plugins/yazi.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/editor/yazi.lua";
  };
}
