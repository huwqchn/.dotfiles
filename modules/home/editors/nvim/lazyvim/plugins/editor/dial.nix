{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.dial;
in {
  options.my.neovim.lazyvim.dial = {
    enable = mkEnableOption "Increment and decrement numbers, dates, and more";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      dial-nvim
    ];
    xdg.configFile."nvim/lua/plugins/dial.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/coding/dial.lua";
  };
}
