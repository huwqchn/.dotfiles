{
  imports = [
    # Include the results of the hardware scan.
    # TODO: we give nios-factor a try
    ./hardware-configuration.nix
    (import ../common/disko/luks-btrfs-tmpfs.nix {})
  ];

  my = {
    boot = {
      # TODO: this is should be enabled by default
      secureBoot = true;
      tmpOnTmpfs = false;
      enableKernelTweaks = true;
      loadRecommendedModules = true;
      # TODO: diable for debugging
      plymouth.enable = false;

      initrd = {
        enableTweaks = true;
        optimizeCompressor = true;
      };

      fs = [
        "ext4"
        "btrfs"
        "xfs"
        "ntfs"
        "fat"
        "vfat"
        "exfat"
      ];
    };
    video.enable = true;
    btrbk.enable = true;
    zram.enable = true;
    game.enable = false;
    security.enable = true;
    services = {
      onedrive.enable = true;
      printing.enable = true;
    };
    virtual.enable = true;
    persistence.enable = true;
    machine = {
      type = "desktop";
      cpu = "intel";
      gpu = "nvidia";
      hasSound = true;
      hasBluetooth = true;
      hasPrinter = false;
      hasTPM = true;
      hasHidpi = true;
    };
  };
}
