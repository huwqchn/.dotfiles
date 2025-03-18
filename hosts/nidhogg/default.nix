{inputs, ...}: {
  modules = [
    ./config.nix
    inputs.wsl.nixosModules.default
  ];
}
