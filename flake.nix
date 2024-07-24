{
  description = "my NixOS flakes configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # user configuration management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for macos
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-gaming.url = "github:fufexan/nix-gaming";

    daeuniverse.url = "github:daeuniverse/flake.nix";

    ags.url = "github:Aylur/ags";

   
    disko = {
      url = "github:nix-community/disko/v1.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, dedsec-grub-theme, ... } @ inputs:
  let
    inherit (inputs.nixpkgs) lib;
    myvars = import ./vars { inherit lib; };
    specialArgs = {
      inherit inputs myvars;
    };
    nixosSystem = "x86_64-linux";
    darwinSystem = "aarch64-darwin";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = nixosSystem;
      inherit specialArgs;
      modules = [
        dedsec-grub-theme.nixosModule
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

    darwinConfigurations.dailydev = nix-darwin.lib.darwinSystem {
      system = darwinSystem;
      inherit specialArgs;
      modules = [
        ./darwin/configuration.nix
        home-manager.darwinModules.home-manager
      ];
    };
    # nix code formatter
    formatter.${darwinSystem} = nixpkgs.legacyPackages.${darwinSystem}.alejandra;
    formatter.${nixosSystem} = nixpkgs.legacyPackages.${nixosSystem}.alejandra;
  };
}
