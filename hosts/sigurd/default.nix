{
  nixos-generators,
  programs-sqlite,
  home-manager,
  ...
}: {
  modules = [
    ../../modules/nixos
    ./__config
    home-manager.nixosModules.home-manager
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
  ];
}
