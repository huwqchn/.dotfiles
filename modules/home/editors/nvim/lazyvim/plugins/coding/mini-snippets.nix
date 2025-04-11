{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.mini-snippets;
in {
  options.my.neovim.lazyvim.mini-snippets = {
    enable = mkEnableOption "Code snippet engine - mini-snippets";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins;
      [
        {
          name = "mini.snippets";
          path = mini-nvim;
        }
        friendly-snippets
      ]
      ++ lib.optionals (config.my.neovim.lazyvim.cmp == "nvim-cmp") [cmp-mini-snippets];

    my.neovim.lazyvim.excludePlugins = with pkgs.vimPlugins; [
      nvim-snippets
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.coding.mini-snippets" },
    '';
  };
}
