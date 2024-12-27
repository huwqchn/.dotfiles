{ nix-darwin }: {
  system = "aarch64-linux";

  modules = [
    ../../modules/darwin
  ];
  output = "darwinConfigurations";
  builder = nix-darwin.lib.darwinSystem;
}
