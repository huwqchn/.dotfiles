{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my.themes) theme wallpaper;
  autoEnable = theme == "auto";
  image = wallpaper;
in {
  stylix = {
    enable = true;
    # FIXME: Is stylix can config fonts opacity cursor icons and wall but not colors?
    inherit autoEnable image;

    # We need set a default colorscheme when we don't set wall
    base16Scheme = mkIf (image == null) "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      serif = {
        package = pkgs.source-han-serif;
        name = "Source Han Serif SC";
      };
      sansSerif = {
        package = pkgs.source-han-sans;
        name = "Source Han Sans SC";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 14;
        terminal = 12;
      };
    };
    opacity = {
      terminal = 0.70;
      popups = 0.85;
      desktop = 0.80;
    };
  };
}
