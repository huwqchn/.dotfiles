# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{disko, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    disko.nixosModules.disko
    ../../_internal/disko/luks-btrfs-tmpfs.nix
    ./boot.nix
    ./impermanence.nix
    # ../../_internal/lanzaboote.nix
  ];

  hardware.nvidia = {
    modesetting.enable = true;
  };

  # my custom modules
  modules = {
    btrbk.enable = true;
    clamav.enable = true;
    # onedrive.enable = true;
    fhs.enable = true;
    zram.enable = true;
    virtual.enable = true;
    peripherals.enable = true;
    security.enable = true;
    atuin-autosync.enable = true;
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
