{
  nixos-generators,
  programs-sqlite,
  home-manager,
  agenix,
  ...
}: {
  modules = [
    ./__config
    ../../modules/nixos
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
    home-manager.darwinModules.home-manager
    agenix.darwinModules.default
  ];
}
