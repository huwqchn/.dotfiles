{lib, ...}: let
  core = import ./core.nix {
    inherit lib;
  };
in
  core.deepMerge [
    core
    (core.importAndMerge [
      ./paths.nix
      ./modules.nix
    ] {inherit lib;})
  ]
