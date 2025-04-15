{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  my = {
    boot = {
      # TODO: this is should be enabled by default
      secureBoot = false;
      tmpOnTmpfs = true;
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
    yubikey.enable = true;
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
    machine = {
      type = "desktop";
      cpu = "intel";
      gpu = "nvidia";
      hasSound = true;
      hasBluetooth = true;
      hasPrinter = false;
      hasTPM = false;
      isHidpi = true;
      persist = true;
    };
  };
}
