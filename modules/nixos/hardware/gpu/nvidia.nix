{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf mkMerge mkDefault;
  isWayland = config.my.desktop.wayland.enable;
  isNvidia = config.my.machine.gpu == "nvidia";
  isHybrid = config.my.machine.gpu == "hybrid-nv";
in {
  config = mkIf isNvidia {
    # nvidia drivers kinda are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {videoDrivers = ["nvidia"];}

      # xorg settings
      (mkIf (!isWayland) {
        # disable DPMS
        monitorSection = ''
          Option "DPMS" "false"
        '';

        # disable screen blanking in general
        serverFlagsSection = ''
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
          Option "BlankTime" "0"
        '';
      })
    ];

    boot = {
      # blacklist mouveau module as otherwise it conflicts with nvidia drm
      blacklistedKernelModules = ["nouveau"];

      # Enable the Nvidia's experimental framebuffer device
      # fix for the imaginary monitor taht does not exist
      kernelModules = ["nvidia_drm.fbdev=1"];
    };

    environment.sessionVariables = mkMerge [
      {LIBVA_DRIVER_NAME = "nvidia";}
      (mkIf isWayland {
        WLR_DRM_DEVICES = mkDefault "/dev/dri/card1";
      })
    ];

    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia

      # mesa
      mesa

      # vulkan
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer

      # libva
      libva
      libva-utils
    ];

    hardware = {
      nvidia = {
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;

        prime.offload = {
          enable = isHybrid;
          enableOffload = isHybrid;
        };

        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault false;
        };

        open = false; # don't use the open drivers by default
        nvidiaSettings = false; # adds nvidia-settings to pkgs, so useless on nixos
        nvidiaPersistenced = true;
      };

      graphics = {
        extraPackages = [pkgs.nvidia-vaapi-driver];
        extraPackages32 = [pkgs.pkgsi686Linux.nvidai-vaapi-driver];
      };
    };
  };
}
