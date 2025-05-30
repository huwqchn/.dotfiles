{lib, ...}: let
  arg = {inherit lib;};
  core = import ./core.nix arg;
in
  core.deepMerge [
    core
    (core.importAndMerge [
        ./paths.nix
        ./hosts.nix
        ./modules.nix
        ./hardware.nix
        ./theme.nix
        ./helper.nix
      ]
      arg)
  ]
