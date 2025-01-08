{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.luasnip;
in {
  options.my.neovim.lazyvim.luasnip = {
    enable = mkEnableOption "Code snippet engine - LuaSnip";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins;
      [
        LuaSnip
      ]
      ++ optional (config.my.neovim.lazyvim.cmp == "nvim-cmp") [cmp_luanip];

    my.neovim.lazyvim.excludePlugins = with pkgs.VimPlugins; [
      nvim-snippets
    ];

    xdg.configFile."nvim/lua/plugins/luasnip.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/coding/luasnip.lua";
  };
}
