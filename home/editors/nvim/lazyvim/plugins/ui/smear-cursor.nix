{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.smear-cursor;
in {
  options.my.neovim.lazyvim.smear-cursor = {
    enable = mkEnableOption "animate cursor";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      smear-cursor-nvim
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.ui.smear-cursor" },
    '';
  };
}
