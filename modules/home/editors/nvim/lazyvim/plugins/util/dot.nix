{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.dot;
in {
  options.my.neovim.lazyvim.dot = {
    enable = mkEnableOption "Language support for dotfiles";
  };

  config = mkIf cfg.enable {
    my.neovim.treesitterParsers = [
      "jsonc"
      "bash"
      "hyprlang"
      "fish"
      "rasi"
    ];

    programs.neovim.extraPackages = with pkgs; [
      shellcheck
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.util.dot" },
    '';
  };
}
