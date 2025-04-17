{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim;
in {
  config = mkIf (cfg.explorer == "neo-tree") {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      neo-tree
    ];

    xdg.configFile = mkMerge [
      (sourceLua "editor/neo-tree.lua")
    ];
  };
}
