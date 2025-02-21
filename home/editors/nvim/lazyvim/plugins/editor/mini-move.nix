{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.mini-move;
in {
  options.my.neovim.lazyvim.mini-move = {
    enable = mkEnableOption "Mini move";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.move";
        path = mini-nvim;
      }
    ];
    xdg.configFile."nvim/lua/plugins/mini-move.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/editor/mini-move.lua";
  };
}
