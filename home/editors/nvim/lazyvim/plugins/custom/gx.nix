{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.gx;
in {
  options.my.neovim.lazyvim.gx = {
    enable = mkEnableOption "gx browse";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      gx-nvim
    ];

    xdg.configFile."nvim/lua/plugins/gx.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/ui/gx.lua";
  };
}
