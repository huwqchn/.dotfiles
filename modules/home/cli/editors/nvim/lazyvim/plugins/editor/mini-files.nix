{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
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

    my.neovim.lazyvim.config = ["editor/mini-files.lua"];
  };
}
