{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  cfg = config.my.neovim.lazyvim.config;
in {
  options.my.neovim.lazyvim.config = {
    enable = mkEnableOption "LazyVim custom settings";
  };

  config = lib.mkIf cfg.enable {
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
    xdg.configFile."nvim/lua/plugins/icons.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/icons.lua";
    xdg.configFile."nvim/lua/plugins/lsp.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/lsp.lua";
    xdg.configFile."nvim/lua/plugins/treesitter.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/treesitter.lua";
    xdg.configFile."nvim/lua/plugins/ui.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/ui.lua";
    xdg.configFile."nvim/lua/config".source = lib.my.relativeToConfig "nvim/lua/config";
    xdg.configFile."nvim/snippets".source = lib.my.relativeToConfig "nvim/snippets";
    xdg.configFile."nvim/spell".source = lib.my.relativeToConfig "nvim/spell";
  };
}
