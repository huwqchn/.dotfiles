{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.mini-files;
in {
  options.my.neovim.lazyvim.mini-files = {
    enable = mkEnableOption "Mini files explorer";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.files";
        path = mini-nvim;
      }
    ];
    xdg.configFile."nvim/lua/plugins/mini-files.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/editor/mini-files.lua";
  };
}
