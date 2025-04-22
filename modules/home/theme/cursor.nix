{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe';
  inherit (config.my.theme) cursor;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  hyprctl' = getExe' pkgs.hyprland "hyprctl";
  enable = cursor != null && config.my.desktop.enable && isLinux;
in {
  config = mkIf enable {
    # If your theme for mouse cursor, icons or windows don't load correctly,
    # try setting them with home.pointerCursor and gtk.theme,
    # which enable a bunch of compatibility options that should make the theme load in all situations.
    home.pointerCursor = {
      inherit (cursor) name package size;
      gtk.enable = true;
      x11.enable = true;
    };
    gtk.cursorTheme = {
      inherit (cursor) name package size;
    };
    wayland.windowManager.hyprland.settings = {
      env = [
        "HYPRCURSOR_THEME,${cursor.name}"
        "HYPRCURSOR_SIZE,${toString cursor.size}"
      ];
      exec-once = [
        # set cursor for HL itself
        "${hyprctl'} setcursor ${cursor.name} ${toString cursor.size}"
      ];
    };
    xdg.dataFile."icon/${cursor.name}".source = "${cursor.package}/share/icons/${cursor.name}";
  };
}
