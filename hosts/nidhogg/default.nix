{
  wsl,
  nixos-generators,
  programs-sqlite,
  ...
}: {
  modules = [
    ./config.nix
    wsl.nixosModules.default
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
  ];
}
