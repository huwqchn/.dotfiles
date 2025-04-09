{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
    ../../modules/common/agenix.nix
  ];

  age = {
    secretsDir = "${config.home.homeDirectory}/.agenix";
  };
}
