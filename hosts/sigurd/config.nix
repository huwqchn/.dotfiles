{inputs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    inputs.nixos-generators.nixosModules.all-formats
    inputs.programs-sqlite.nixosModules.programs-sqlite
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
