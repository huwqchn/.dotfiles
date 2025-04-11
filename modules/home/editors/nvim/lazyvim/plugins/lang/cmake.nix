{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.cmake;
in {
  options.my.neovim.lazyvim.cmake = {
    enable = mkEnableOption "language cmake";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      cmake-language-server
      cmake-lint
      neocmakelsp
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      cmake-tools-nvim
    ];

    my.neovim.treesitterParsers = [
      "cmake"
    ];

    my.neovim.lazyvim.excludePlugins = with pkgs.vimPlugins; [
      cmake-tools-nvim
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.cmake" },
    '';
  };
}
