{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) isWayland;
  enable = isWayland config;
in {
  config = mkIf enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      GDK_BACKEND = "wayland,x11";
      ANKI_WAYLAND = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      #WLR_DRM_NO_ATOMIC = "1";
      #WLR_BACKEND = "vulkan";
      #__GL_GSYNC_ALLOWED = "0";
      #__GL_VRR_ALLOWED = "0";
    };
  };
}
