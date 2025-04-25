{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      env = [
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_SCALE,1"
        "GDK_DPI_SCALE,1"
        "SDL_VIDEODRIVER,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
        "SDL_VIDEODRIVER,wayland"
        # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
        # "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        # "GBM_BACKEND,nvidia-drm"
        # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # fix https://github.com/hyprwm/Hyprland/issues/1520
        # "WLR_NO_HARDWARE_CURSORS,1"
      ];
    };
  };
}
