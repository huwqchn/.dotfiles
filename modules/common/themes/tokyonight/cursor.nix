{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.my) capitalize;
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (config.my.themes) theme tokyonight colorscheme;
  inherit (colorscheme) palette;
  cfg = tokyonight;
  colorName = "${capitalize theme}-${capitalize cfg.style}";
  enable = cfg.enable && config.my.desktop.enable && isLinux;
  variant = "modern";
  cursorName = "Bibata-${capitalize variant}-${colorName}-Hyprcursor";
  cursorPackage = pkgs.bibata-hyprcursor.overrideAttrs (_old: {
    inherit (palette.cursor) baseColor outlineColor watchBackgroundColor;
    inherit variant colorName;
  });
in {
  config = mkIf enable {
    my.themes.cursor = {
      name = cursorName;
      package = cursorPackage;
      size = 24;
    };
  };
}
