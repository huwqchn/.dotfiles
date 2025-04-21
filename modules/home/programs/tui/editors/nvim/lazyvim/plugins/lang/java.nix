{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.java;
in {
  options.my.neovim.lazyvim.java = {
    enable = mkEnableOption "language java";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "java"
      ];

      lazyvim = {
        extraPlugins = with pkgs.vimPlugins; [
          nvim-jdtls
        ];

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.java" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      vscode-extensions.vscjava.vscode-java-debug
      vscode-extensions.vscjava.vscode-java-test
    ];
  };
}
