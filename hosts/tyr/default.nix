{ darwin, home-manager, ... }: {
  system = "aarch64-darwin";

  modules = [
    ../../modules/darwin
    home-manager.darwinModules.home-manager
  ];
  output = "darwinConfigurations";
  builder = darwin.lib.darwinSystem;
}
