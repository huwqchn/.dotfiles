{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.java;
in {
  options.my.neovim.lazyvim.java = {
    enable = mkEnableOption "language java";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      vscode-extensions.vscjava.vscode-java-debug
      vscode-extensions.vscjava.vscode-java-test
    ];

    my.neovim.treesitterParsers = [
      "java"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      nvim-jdtls
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.java" },
    '';
  };
}
