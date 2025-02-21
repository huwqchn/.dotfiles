{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.winshift;
in {
  options.my.neovim.lazyvim.winshift = {
    enable = mkEnableOption "window winshift";
  };

  config = mkIf cfg.enable {
    my.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      winshift
    ];

    xdg.configFile."nvim/lua/plugins/winshift.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/ui/winshift.lua";
  };
}
