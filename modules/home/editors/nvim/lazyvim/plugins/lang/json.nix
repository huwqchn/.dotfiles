{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.json;
in {
  options.my.neovim.lazyvim.json = {
    enable = mkEnableOption "language json";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      bacon
      rust-analyzer
      vscode-extensions.vadimcn.vscode-lldb
    ];

    my.neovim.treesitterParsers = [
      "json5"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      SchemaStore-nvim
      crates-nvim
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.json" },
    '';
  };
}
