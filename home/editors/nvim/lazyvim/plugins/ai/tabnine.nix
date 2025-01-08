{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.tabnine;
in {
  options.my.neovim.lazyvim.tabnine = {
    enable = mkEnableOption "AI plugin - tabnine";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      tabnine-nvim
      cmp-tabnine
    ];

    xdg.configFile."nvim/lua/plugins/tabnine.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/ai/tabnine.lua";
  };
}
