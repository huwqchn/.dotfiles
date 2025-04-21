{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.zig;
in {
  options.my.neovim.lazyvim.zig = {
    enable = mkEnableOption "language zig";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "zig"
      ];

      lazyvim = {
        extraPlugins = with pkgs.vimPlugins; [
          neotest-zig
        ];

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.zig" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      zls
    ];
  };
}
