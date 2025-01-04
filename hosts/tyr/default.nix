{
  darwin,
  home-manager,
  ...
}: {
  system = "aarch64-darwin";

  modules = [
    ../../modules/darwin
    ../../modules/my.nix
    ./__config
    home-manager.darwinModules.home-manager
  ];
  output = "darwinConfigurations";
  builder = darwin.lib.darwinSystem;
}
