{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.rust;
in {
  options.my.neovim.lazyvim.rust = {
    enable = mkEnableOption "language rust";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "rust"
        "ron"
      ];

      lazyvim = {
        extraPlugins = with pkgs.vimPlugins; [
          rustaceanvim
          crates-nvim
        ];

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.rust" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      bacon
      rust-analyzer
      vscode-extensions.vadimcn.vscode-lldb
    ];
  };
}
