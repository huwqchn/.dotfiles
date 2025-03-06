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
}
