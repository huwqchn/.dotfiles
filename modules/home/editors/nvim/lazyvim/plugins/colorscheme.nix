{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
  cfg = config.my.neovim.lazyvim.colorscheme;
in {
  # FIXME: This should be controlled by `my.thesmes` (my rice system)
  options.my.neovim.lazyvim.colorscheme = mkOption {
    type = enum ["tokyonight" "kanagawa" "catppuccin"];
    default = "tokyonight";
    description = ''
      choose the colorscheme of LazyVim
    '';
  };
  config = {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      kanagawa-nvim
      catppuccin-nvim
    ];

    xdg.configFile."nvim/lua/plugins/colorscheme.lua".source =
      lib.my.relativeToConfig "nvim/lua/plugins/extras/colorscheme/${cfg}.lua";
  };
}
