{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) optionalAttrs;
  inherit (lib.my) relativeToConfig;
  cfg = config.my.neovim.lazyvim.config;
in {
  options.my.neovim.lazyvim.config = {
    enable = mkEnableOption "LazyVim custom settings";
  };

  config = mkIf cfg.enable {
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

    xdg.configFile =
      {
        "nvim/lua/plugins/coding.lua".source = relativeToConfig "nvim/lua/plugins/coding.lua";
        "nvim/lua/plugins/editor.lua".source = relativeToConfig "nvim/lua/plugins/editor.lua";
        "nvim/lua/plugins/icons.lua".source = relativeToConfig "nvim/lua/plugins/icons.lua";
        "nvim/lua/plugins/lsp.lua".source = relativeToConfig "nvim/lua/plugins/lsp.lua";
        "nvim/lua/plugins/treesitter.lua".source = relativeToConfig "nvim/lua/plugins/treesitter.lua";
        "nvim/lua/plugins/ui.lua".source = relativeToConfig "nvim/lua/plugins/ui.lua";
        "nvim/lua/config".source = relativeToConfig "nvim/lua/config";
        "nvim/lua/util".source = relativeToConfig "nvim/lua/util";
        "nvim/snippets".source = relativeToConfig "nvim/snippets";
        "nvim/spell".source = relativeToConfig "nvim/spell";
      }
      // optionalAttrs (config.my.keyboardLayout == "colemak") {
        "nvim/lua/plugins/layout.lua".source = relativeToConfig "nvim/lua/plugins/layout.lua";
        "nvim/lua/plugins/extras/colemak.lua".source = relativeToConfig "nvim/lua/plugins/extras/colemak.lua";
      };
  };
}
