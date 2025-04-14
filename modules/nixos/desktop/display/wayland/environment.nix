{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.strings) optionalString;
  inherit (config.my) shell;
  # inherit (config.my.desktop) environment;
  # FIXME: should be add a assert if desktop.environment is not wayland desktop environment
  isHyprland = config.my.desktop.environment == "Hyprland";
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable) {
    environment = {
      etc."greetd/environments".text =
        if config.services.greetd.enable
        then ''
          ${optionalString isHyprland "Hyprland"}
          ${shell}
        ''
        else "";

      variables = {
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
  };
}
