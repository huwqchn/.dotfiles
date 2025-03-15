{
  imports = [
    ./machine.nix
    ./boot.nix
    ../common/nixosDefault.nix
  ];

  # my custom modules
  my = {
    onedrive.enable = true;
    fhs.enable = true;
    zram.enable = true;
    power.enable = true;
    virtual.enable = true;
    security.enable = true;
    desktop.enable = true;
  };
}
