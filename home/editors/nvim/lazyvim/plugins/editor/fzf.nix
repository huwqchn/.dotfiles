{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.neovim.lazyvim;
in {
  config = mkIf (cfg.picker == "fzf") {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      fzf-lua
    ];

    my.neovim.lazyvim.excludePlugins = with pkgs.vimPlugins; [
      telescope-nvim
    ];

    xdg.configFile."nvim/lua/plugins/fzf.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/editor/fzf.lua";
  };
}
