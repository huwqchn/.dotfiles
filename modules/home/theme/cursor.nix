{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my.theme) cursor;
in {
  config = mkIf (cursor != null) {
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
        "hyprctl setcursor ${cursor.name} ${toString cursor.size}"
      ];
    };
    xdg.dataFile."icon/${cursor.name}".source = "${cursor.package}/share/icons/${cursor.name}";
  };
}
