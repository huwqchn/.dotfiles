{
  description = "my NixOS flakes configuration for test";

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils-plus, haumea, pre-commit-hooks, ... }: let
    inherit (inputs.nixpkgs) lib;
    mylib = import ./lib { inherit lib; };
    myvars = import ./vars { inherit lib; };
    system = "x86_64-linux";
    specialArgs = inputs // {
      inherit mylib myvars;
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    hl = haumea.lib;
    hosts = hl.load {
      src = ./hosts;
      # Load it without passing inputs
      loader = hl.loaders.verbatim;
      # Make the default.nix's attrs directly children of lib
      transformer = hl.transformers.liftDefault;
    };
  in flake-utils-plus.lib.mkFlake {
    inherit self inputs;

    channelsConfig = {
      allowUnfree = true;
      allowBroken = true;
    };

    hostDefaults = {
      inherit specialArgs;
      modules = [
        ./modules/nix.nix
        ./modules/nixos
        home-manager.nixosModules.home-manager
        {
          home-manager.backupFileExtension = "hm-bak";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users."${myvars.userName}".imports = [
            ./home
          ];
        }
      ];
    };

    inherit hosts;

    outputsBuilder = channels: let
      pkgs = channels.nixpkgs;
    in {
      checks = {
        pre-commit-check = pre-commit-hooks.lib."${channels.nixpkgs.system}".run {
          src = ./.;
          hooks = {
            alejandra.enable = true; # formatter
            typos = {
              enable = true;
              settings = {
                write = true; # Automatically fix typos
                configPath = "./.typos.toml"; # relative to the flake root
              };
            };
            prettier = {
              enable = true;
              settings = {
                write = true; # Automatically format files
                configPath = "./.prettierrc.yaml"; # relative to the flake root
              };
            };
            deadnix.enable = true; # detect unused variable bindings in "*.nix"
            statix.enable = true; # lints and suggestions for Nix code

          };
        };
      };
      formatter = pkgs.alejandra;
    };
  };

  inputs = {
    # Official NixOS package source, using nixos's unstable branch by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus/v1.4.0";
      inputs.flake-utils.follows = "flake-utils";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";

    };

    # The list of supported systems.
    systems.url = "github:nix-systems/default-linux";

    # disko for declarative partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:huwqchn/wallpapers";
      flake = false;
    };

    # stylix = {
    #  url = "github:danth/stylix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    # };

    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprwm
    # hyprland = {
    #  type = "git";
    #  url = "https://github.com/hyprwm/Hyprland";
    #  submodules = true;
    # };

    # hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #  inputs.hyprland.follows = "hyprland";
    # };

    # neovim nightly overlay
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    # wezterm git
    wezterm-git = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
