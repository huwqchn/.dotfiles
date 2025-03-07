{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
    inputs.programs-sqlite.nixosModules.programs-sqlite
    inputs.disko.nixosModules.disko
    ./disko/luks-lvm-btrfs-tmpfs.nix
    ./impermanence.nix
  ];
  system.stateVersion = lib.mkDefault "24.11"; # Did you read the comment?
}
