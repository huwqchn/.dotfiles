{
  darwin,
  home-manager,
  agenix,
  ...
}: {
  system = "aarch64-darwin";

  modules = [
    ./__config
    ../../modules/darwin
    home-manager.darwinModules.home-manager
    agenix.darwinModules.default
  ];

  output = "darwinConfigurations";
  builder = darwin.lib.darwinSystem;
}
