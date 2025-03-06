{
  inputs,
  lib,
  ...
}: let
  specialArgs = inputs // {inherit lib;};
in {
  flake.darwinConfigurations = {
    tyr = inputs.darwin.lib.darwinSystem {
      inherit specialArgs;
      system = "x86_64-darwin";
      modules = [
        ../modules/darwin
        ../modules/common/my.nix
        ../modules/common/nix.nix
        inputs.home-manager.darwinModules.home-manager
        inputs.agenix.darwinModules.default
        ../modules/common/home-manager.nix
        {home-manager.extraSpecialArgs = specialArgs;}
      ];
    };
  };
}
