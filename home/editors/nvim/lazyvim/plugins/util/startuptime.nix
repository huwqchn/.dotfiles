{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.startuptime;
in {
  options.my.neovim.lazyvim.startuptime = {
    enable = mkEnableOption "startuptime";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      startuptime-nvim
    ];
    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.util.startuptime" },
    '';
  };
}
