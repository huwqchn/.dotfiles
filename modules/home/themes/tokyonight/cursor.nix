{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.themes.tokyonight;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  enable = cfg.enable && config.my.desktop.enable && isLinux;
in {
  config = mkIf enable {
    # If your themes for mouse cursor, icons or windows don't load correctly,
    # try setting them with home.pointerCursor and gtk.theme,
    # which enable a bunch of compatibility options that should make the themes load in all situations.
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
    gtk.cursorTheme = {
      name = "Bibata-Modern";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };
}
