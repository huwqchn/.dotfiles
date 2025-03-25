{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # my custom modules
  my = {
    onedrive.enable = true;
    fhs.enable = true;
    zram.enable = true;
    virtual.enable = true;
    security.enable = true;
    desktop.enable = true;
  };
}
