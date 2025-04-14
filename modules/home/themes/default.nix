{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.my) scanPaths;
  inherit (lib.modules) mkDefault;
  wall = config.my.themes.wallpaper;
in {
  imports =
    (scanPaths ./.)
    ++ [
      inputs.stylix.homeManagerModules.stylix
    ];
  stylix = {
    enable = true;
    autoEnable = mkDefault false;
    # TODO: TEST this, since I change a lot of things
    image = wall;
    # TODO: use stylix manage my font and cursor
  };

  # TODO: use gowall to change wallpaper to apply my colorscheme
  home.packages = with pkgs; [
    gowall
  ];

  # WARNING: This should not be used in `auto` theme, cause gowall is change a wallpaper to specific colorscheme
  # but `auto` theme is generate a colorshecme based on wallpaper
  # TODO: should make gowall working seemlessly
  home.file.".config/gowall/config.yml".text = with config.lib.stylix.colors; ''
    themes:
      - name: "global"
        colors:
          - "#${base00}"
          - "#${base01}"
          - "#${base02}"
          - "#${base03}"
          - "#${base04}"
          - "#${base05}"
          - "#${base06}"
          - "#${base07}"
          - "#${base08}"
          - "#${base09}"
          - "#${base0A}"
          - "#${base0B}"
          - "#${base0C}"
          - "#${base0D}"
          - "#${base0E}"
          - "#${base0F}"
  '';
}
