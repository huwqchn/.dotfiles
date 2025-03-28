{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.strings) optionalString;
  inherit (lib.my) scanPaths;

  inherit (config.my) shell;
  isHyprland = config.my.desktop.default == "hyprland";
  cfg = config.my.desktop.wayland;
in {
  imports = scanPaths ./.;

  config = mkIf cfg.enable {
    services.xserver.enable = mkDefault false;

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

    systemd.services.seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${getExe pkgs.seatd} -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
