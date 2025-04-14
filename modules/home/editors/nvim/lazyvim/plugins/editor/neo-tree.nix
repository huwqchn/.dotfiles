{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim;
in {
  config = mkIf (cfg.explorer == "neo-tree") {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      neo-tree
    ];

    xdg.configFile."nvim/lua/plugins/neo-tree.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/editor/neo-tree.lua";
  };
}
