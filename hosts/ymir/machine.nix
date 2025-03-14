{inputs, ...}: {
  import = [
    inputs.hardware.nixosModules.dell-xps-15-9560-nvidia
  ];

  boot.initrd.kernelModules = ["dm-snapshot"];

  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
  ];

  my.machine = {
    type = "laptop";
    gpu = "nvidia";
    cpu = "intel";
    useWifi = true;
    isHidpi = true;
    persist = true;
  };
}
