{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfgWayland = config.modules.desktop.wayland;
  cfgXorg = config.modules.desktop.xorg;
in {
  options.modules.desktop = {
    wayland = {
      enable = mkEnableOption "Wayland Display Server";
    };
    xorg = {
      enable = mkEnableOption "Xorg Display Server";
    };
  };

  config = mkMerge [
    (mkIf cfgWayland.enable {
      ####################################################################
      #  NixOS's Configuration for Wayland based Window Manager
      ####################################################################
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
        ];
      };

      services.xserver.enable = false; # disable xorg server

      # fix https://github.com/ryan4yin/nix-config/issues/10
      security.pam.services.swaylock = {};
    })

    (mkIf cfgXorg.enable {
      ####################################################################
      #  NixOS's Configuration for Xorg Server
      ####################################################################

      services = {
        gvfs.enable = true; # Mount, trash, and other functionalities
        tumbler.enable = true; # Thumbnail support for images

        xserver = {
          enable = true;
          desktopManager = {
            runXdgAutostartIfNone = true;
            session = [
              {
                name = "hm-session";
                manage = "window";
                start = ''
                  ${pkgs.runtimeShell} $HOME/.xsession &
                  waitPID=$!
                '';
              }
            ];
          };
          # Configure keymap in X11
          xkb.layout = "us";
        };
      };
    })
  ];
}
