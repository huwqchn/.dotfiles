{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.mini-animate;
in {
  options.my.neovim.lazyvim.mini-animate = {
    enable = mkEnableOption "Mini animate";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      {
        name = "mini.animate";
        path = mini-nvim;
      }
    ];
    xdg.configFile."nvim/lua/plugins/mini-animate.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/ui/mini-animate.lua";
  };
}
