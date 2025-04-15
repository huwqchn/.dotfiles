{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkDefault;
  inherit (config.my) desktop;
  wall = config.my.themes.wallpaper;
  autoTheme = config.my.themes.theme == "auto";
in {
  stylix = {
    # NOTE: if I set desktop disable that will make image is null taht make stylix can't compiled
    # so I must set stylix disable when desktop is disable
    # TODO: I need add a defualt colorscheme when autoEnable is true but the wall is null
    inherit (desktop) enable;
    # FIXME: Is stylix can config fonts opacity cursor icons and wall but not colors?
    autoEnable = mkDefault autoTheme;
    # polarity = mkDefault "dark";
    image = mkDefault wall;
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
