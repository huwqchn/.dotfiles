# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{disko, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    disko.nixosModules.disko
    ../../_internal/disko/luks-lvm-btrfs-tmpfs.nix
    ./boot.nix
    ./impermanence.nix
    # ../../_internal/lanzaboote.nix
  ];

  # fix timed out for device /dev/tpmrm0
  # systemd.units."dev-tpmrm0.device".enable = false;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
