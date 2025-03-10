{inputs, ...}: {
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
    inputs.programs-sqlite.nixosModules.programs-sqlite
    inputs.disko.nixosModules.disko
    ./disko/luks-lvm-btrfs-tmpfs.nix
    ./peripherals.nix
    ./networkmanager.nix
    ./btrbk.nix
  ];
}
