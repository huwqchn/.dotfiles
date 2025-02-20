{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.overseer;
in {
  options.my.neovim.lazyvim.overseer = {
    enable = mkEnableOption "overseer";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      overseer-nvim
    ];
    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.editor.overseer" },
    '';
  };
}
