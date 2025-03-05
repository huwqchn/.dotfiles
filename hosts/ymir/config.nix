# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    ../common/nixosDefault.nix
  ];

  # fix timed out for device /dev/tpmrm0
  # systemd.units."dev-tpmrm0.device".enable = false;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking = {
  #   networkmanager.enable = true; # Easiest to use and most distros use this by default.
  # };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  # my custom modules
  my = {
    btrbk.enable = true;
    clamav.enable = true;
    onedrive.enable = true;
    fhs.enable = true;
    zram.enable = true;
    power.enable = true;
    virtual.enable = true;
    peripherals.enable = true;
    security.enable = true;
    atuin-autosync.enable = true;
  };
}
