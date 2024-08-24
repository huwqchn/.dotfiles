# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
let
  hostName = "hacker";
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    inherit hostName;
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };
  hardware.nvidia = {
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
    # package = config.boot.kernelPackages.nvidiaPackages.stable;

    # required by most wayland compositors!
    modesetting.enable = true;
    powerManagement.enable = true;
  };
  # hardware.nvidia-container-toolkit.enable = true; # for nvidia-docker

  # hardware.opengl = {
  #   enable = true;
  # };

  # virtualisation
  #hardware.graphics = {
  #  enable = true;
    # needed by nvidia-docker
  #  enable32Bit = true;
  #};
  system.stateVersion = "24.05"; # Did you read the comment?
}
