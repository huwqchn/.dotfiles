{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.neovim.lazyvim;
in {
  config = mkIf (cfg.picker == "telescope") {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-undo-nvim
      scope-nvim
    ];

    my.neovim.lazyvim.excludePlugins = with pkgs.vimPlugins; [
      fzf-lua
    ];

    xdg.configFile."nvim/lua/plugins/telescope.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/editor/telescope.lua";
  };
}
