{
  self,
  inputs,
  inputs',
  lib,
  ...
}: let
  specialArgs = {inherit self inputs inputs' lib;};
in {
  flake.darwinConfigurations = {
    tyr = inputs.darwin.lib.darwinSystem {
      inherit specialArgs;
      system = "aarch64-darwin";
      modules = [
        ../modules/darwin
        inputs.home-manager.darwinModules.home-manager
        inputs.agenix.darwinModules.default
      ];
    };
  };
}
