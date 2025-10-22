{
  config,
  pkgs,
  ...
}: let
  # inherit (lib.options) mkOption;
  # inherit (lib.types) enum;
  inherit (config.my.theme) default;
in {
  # options.my.neovim.lazyvim.colorscheme = mkOption {
  #   type = enum ["tokyonight" "kanagawa" "catppuccin"];
  #   default = "tokyonight";
  #   description = ''
  #     choose the colorscheme of LazyVim
  #   '';
  # };

  config = {
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins;
        if default == "tokyonight"
        then [
          tokyonight-nvim
        ]
        # TODO: should define a my.theme.kanagawa
        else if default == "kanagawa"
        then [
          kanagawa-nvim
        ]
        # TODO: should define a my.theme.catppuccin
        else if default == "catppuccin"
        then [
          catppuccin-nvim
        ]
        else [];

      # FIXME: not working when theme is auto
      config = ["colorscheme/${default}.lua"];
    };
  };
}
