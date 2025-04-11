{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim;
in {
  config = mkIf (cfg.cmp == "nvim-cmp") {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      nvim-snippets
      friendly-snippets
      # my custom nvim plugins
      cmp-cmdline
      cmp-emoji
      cmp-nvim-lua
      cmp-cmdline-history
      cmp-nvim-lsp
    ];

    my.neovim.lazyvim.excludePlugins = with pkgs.vimPlugins; [
      blink-cmp
      blink-compat
    ];

    xdg.configFile."nvim/lua/plugins/nvim-cmp.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/coding/nvim-cmp.lua";
  };
}
