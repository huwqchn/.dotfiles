{inputs, ...}: {
  modules = [
    ./config.nix
    inputs.wsl.nixosModules.default
    inputs.nixos-generators.nixosModules.all-formats
    inputs.programs-sqlite.nixosModules.programs-sqlite
  ]
}
