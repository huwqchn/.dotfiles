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
    programs.neovim.extraPackages = with pkgs; [
      zls
    ];

    my.neovim.treesitterParsers = [
      "zig"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      neotest-zig
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.zig" },
    '';
  };
}
