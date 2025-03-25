{
  imports = [
    ./machine.nix
  ];

  # my custom modules
  my = {
    onedrive.enable = true;
    fhs.enable = true;
    btrbk.enable = true;
    zram.enable = true;
    power.enable = true;
    virtual.enable = true;
    security.enable = true;
    desktop.enable = true;
  };
}
