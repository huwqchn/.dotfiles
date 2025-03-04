{
  nixos-generators,
  programs-sqlite,
  ...
}: {
  modules = [
    ./config.nix
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
  ];
}
