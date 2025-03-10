{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    ../common/nixosDefault.nix
  ];

  hardware.nvidia = {modesetting.enable = true;};

  # my custom modules
  my = {
    onedrive.enable = true;
    fhs.enable = true;
    zram.enable = true;
    virtual.enable = true;
    security.enable = true;
    persist.enable = true;
    desktop.enable = true;
  };
}
