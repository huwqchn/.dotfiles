{
  disko,
  nixos-generators,
  programs-sqlite,
  lib,
  ...
}: {
  imports = [
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
    disko.nixosModules.disko
    ./disko/luks-lvm-btrfs-tmpfs.nix
    ./impermanence.nix
    # ../../_internal/lanzaboote.nix
  ];
  system.stateVersion = lib.mkDefault "24.11"; # Did you read the comment?
}
