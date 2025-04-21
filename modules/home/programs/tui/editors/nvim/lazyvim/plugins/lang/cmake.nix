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
    my.neovim = {
      treesitterParsers = [
        "cmake"
      ];
      lazyvim = {
        excludePlugins = with pkgs.vimPlugins; [
          cmake-tools-nvim
        ];

        extraPlugins = with pkgs.vimPlugins; [
          cmake-tools-nvim
        ];

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.cmake" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      cmake-language-server
      cmake-lint
      neocmakelsp
    ];
  };
}
