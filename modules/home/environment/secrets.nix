{inputs, ...}: {
  imports = [
    inputs.sops.homeManagerModules.sops
    ../../common/secrets.nix
  ];
}
