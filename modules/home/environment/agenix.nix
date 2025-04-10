{
  inputs,
  config,
  ...
}: let
  inherit (config.home) homeDirectory;
in {
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
    ../../common/agenix.nix
  ];

  age = {
    secretsDir = "${homeDirectory}/.agenix";
    secretsMountPoint = "${homeDirectory}/.agenix/agenix.d";
  };
}
