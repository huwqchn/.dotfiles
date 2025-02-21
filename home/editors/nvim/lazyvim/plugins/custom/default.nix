{
  lib,
  pkgs,
  ...
}: {
  imports = lib.my.scanPaths ./.;
  my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
    {
      name = "mini.align";
      path = mini-nvim;
    }
    {
      name = "mini.operators";
      path = mini-nvim;
    }
    {
      name = "mini.bracketed";
      path = mini-nvim;
    }
    treesj
    nvim-spider
    smart-splits-nvim
    diffview-nvim
    git-blame-nvim
    git-conflict-nvim
    undotree
    playground
    dropbar-nvim
    scope-nvim
  ];
  xdg.configFile."nvim/lua/plugins/coding.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/coding.lua";
  xdg.configFile."nvim/lua/plugins/editor.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/editor.lua";
  xdg.configFile."nvim/lua/plugins/icon.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/icon.lua";
  xdg.configFile."nvim/lua/plugins/lsp.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/lsp.lua";
  xdg.configFile."nvim/lua/plugins/treesitter.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/treesitter.lua";
  xdg.configFile."nvim/lua/plugins/ui.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/ui.lua";
}
