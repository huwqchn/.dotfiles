{inputs, ...}: {
  imports = [
    ./machine.nix
    ./boot.nix
    inputs.nixos-generators.nixosModules.all-formats
    inputs.programs-sqlite.nixosModules.programs-sqlite
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
