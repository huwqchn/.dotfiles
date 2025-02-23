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
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [winshift-nvim];

    xdg.configFile."nvim/lua/plugins/winshift.lua".source =
      lib.my.relativeToConfig "nvim/lua/plugins/extras/ui/winshift.lua";
  };
}
