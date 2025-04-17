{
  config,
  lib,
  pkgs,
  ...
}: let
  # inherit (lib.options) mkOption;
  # inherit (lib.types) enum;
  inherit (lib.modules) mkMerge;
  inherit (lib.my) sourceLua;
  inherit (config.my.themes) theme;
in {
  # options.my.neovim.lazyvim.colorscheme = mkOption {
  #   type = enum ["tokyonight" "kanagawa" "catppuccin"];
  #   default = "tokyonight";
  #   description = ''
  #     choose the colorscheme of LazyVim
  #   '';
  # };

  config = {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins;
      if theme == "tokyonight"
      then [
        tokyonight-nvim
      ]
      else if theme == "kanagawa"
      then [
        kanagawa-nvim
      ]
      else if theme == "catppuccin"
      then [
        catppuccin-nvim
      ]
      else [];

    # FIXME: not working when theme is auto
    xdg.configFile = mkMerge [
      (sourceLua "colorscheme/${theme}.lua")
    ];
  };
}
