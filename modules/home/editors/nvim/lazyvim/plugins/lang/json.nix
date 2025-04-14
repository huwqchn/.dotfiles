{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.json;
in {
  options.my.neovim.lazyvim.json = {
    enable = mkEnableOption "language json";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "json5"
      ];

      lazyvim = {
        extraPlugins = with pkgs.vimPlugins; [
          SchemaStore-nvim
          crates-nvim
        ];

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.json" },
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
