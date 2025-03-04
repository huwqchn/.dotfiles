{
  nixos-generators,
  programs-sqlite,
  home-manager,
  agenix,
  ...
}: {
  modules = [
    ./config.nix
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
  ];
}
