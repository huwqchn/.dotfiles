{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.theme.tokyonight;
  inherit (config.my.machine) hasHidpi;
  # set dpi for 4k monitor
  dpi =
    if hasHidpi
    then 192
    else 96;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  enable = cfg.enable && isLinux;
in {
  config = mkIf enable {
    xresources.properties = {
      # dpi for Xorg.s font
      "Xft.dpi" = dpi;
      # or set a generic dpi
      "*.dpi" = dpi;

      # These might also be useful depending on your monitor and personal preferences.
      "Xft.autohint" = 0;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
    };
  };
}
