{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkOption;
  cfg = config.my.neovim.lazyvim.colorscheme;
in {
  options.my.neovim.lazyvim.colorscheme = mkOption {
    type = types.enum ["tokyonight" "kanagawa" "catppuccin"];
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
