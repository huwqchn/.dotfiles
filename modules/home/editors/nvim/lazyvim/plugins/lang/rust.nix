{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.rust;
in {
  options.my.neovim.lazyvim.rust = {
    enable = mkEnableOption "language rust";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      bacon
      rust-analyzer
      vscode-extensions.vadimcn.vscode-lldb
    ];

    my.neovim.treesitterParsers = [
      "rust"
      "ron"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      rustaceanvim
      crates-nvim
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.rust" },
    '';
  };
}
