{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.python;
in {
  options.my.neovim.lazyvim.python = {
    enable = mkEnableOption "language python";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "ninja"
        "rst"
      ];
      lazyvim = {
        extraPlugins = with pkgs.vimPlugins; [
          neotest-python
          nvim-dap-python
          # venv-selector-nvim
        ];

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.python" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      pyright
      ruff
      ruff-lsp
      basedpyright
    ];
  };
}
