{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.dot;
in {
  options.my.neovim.lazyvim.dot = {
    enable = mkEnableOption "Highlight colors in your code";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.hipatterns";
        path = mini-nvim;
      }
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    '';
  };
}
