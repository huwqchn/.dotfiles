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
  inherit (config.my.theme) name;
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
      if name == "tokyonight"
      then [
        tokyonight-nvim
      ]
      # TODO: should define a my.theme.kanagawa
      else if name == "kanagawa"
      then [
        kanagawa-nvim
      ]
      # TODO: should define a my.theme.catppuccin
      else if name == "catppuccin"
      then [
        catppuccin-nvim
      ]
      else [];

    # FIXME: not working when theme is auto
    xdg.configFile = mkMerge [
      (sourceLua "colorscheme/${name}.lua")
    ];
  };
}
