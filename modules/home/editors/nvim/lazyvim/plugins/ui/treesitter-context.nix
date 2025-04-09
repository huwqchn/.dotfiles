{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.treesitter-context;
in {
  options.my.neovim.lazyvim.treesitter-context = {
    enable = mkEnableOption "treesitter context";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      nvim-treesitter-context
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    '';
  };
}
