{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.dell-xps-15-9560-nvidia
  ];

  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];

  fileSystems."/persist".neededForBoot = true; # required by impermanence
  fileSystems."/var/log".neededForBoot = true; # required by nixos

  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  my.machine = {
    type = "laptop";
    gpu = "nvidia";
    cpu = "intel";
    useWifi = true;
    isHidpi = true;
    persist = true;
  };
}
