{
  nixos-wsl,
  home-manager,
  nixos-generators,
  programs-sqlite,
  ...
}: {
  modules = [
    ./__config
    nixos-wsl.nixosModules.default
    home-manager.nixosModules.home-manager
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
  ];
}
