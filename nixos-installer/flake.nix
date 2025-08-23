{
  description = "Minimalist NixOS installer with LUKS encryption and Btrfs filesystem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };
  };

  outputs = {
    nixpkgs,
    disko,
    impermanence,
    ...
  } @ inputs: {
    nixosConfigurations = {
      installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          ./configuration.nix
          ./hardware-configuration.nix
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
