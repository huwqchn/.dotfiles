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

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.coding.luasnip" },
    '';
  };
}
