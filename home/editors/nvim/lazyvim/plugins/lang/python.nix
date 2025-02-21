{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.python;
in {
  options.my.neovim.lazyvim.python = {
    enable = mkEnableOption "language python";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      pyright
      ruff
      ruff-lsp
      basedpyright
    ];

    my.neovim.treesitterParsers = [
      "ninja"
      "rst"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      neotest-python
      nvim-dap-python
      # venv-selector-nvim
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.python" },
    '';
  };
}
