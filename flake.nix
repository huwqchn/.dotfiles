{
  description = "My NixOS flakes configuration makes me feel like the world is my oyster";

  outputs = inputs @ {
    self,
    home-manager,
    flake-utils-plus,
    haumea,
    pre-commit-hooks,
    programs-sqlite,
    nixos-generators,
    ...
  }: let
    inherit (inputs.nixpkgs) lib;
    inherit (flake-utils-plus.lib) mkFlake;
    mylib = import ./lib {inherit lib;};
    myvars = import ./vars;
    specialArgs =
      inputs
      // {
        inherit mylib myvars;
      };
    hl = haumea.lib;
    hosts = hl.load {
      src = ./hosts;
      # Make the default.nix's attrs directly children of lib
      transformer = hl.transformers.liftDefault;
    };
  in
    mkFlake {
      inherit self inputs;

      ############
      # channels #
      ############
      supportedSystems = import inputs.systems;

      channelsConfig = {
        allowUnfree = true;
        allowBroken = true;
      };

      # channels.nixpkgs.overlaysBuilder = channels: [
      #   (final: prev: { inherit (channels.nixpkgs-stable) bat-extras; })
      # ];

      # TODO: rewrite overlays instructures
      sharedOverlays = import ./overlays inputs;

      #########
      # Hosts #
      #########
      inherit hosts;
      hostDefaults = {
        inherit specialArgs;
        modules = [
          ./modules/nix.nix
          ./modules/nixos
          ./secrets
          nixos-generators.nixosModules.all-formats
          programs-sqlite.nixosModules.programs-sqlite
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "hm-bak";
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users."${myvars.userName}".imports = [
                ./home
              ];
            };
          }
        ];
      };

      ###########
      # Outputs #
      ###########
      outputsBuilder = channels: let
        pkgs = channels.nixpkgs;
      in {
        checks = {
          pre-commit-check = pre-commit-hooks.lib."${pkgs.system}".run {
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

        # Development Shells
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            gcc
            alejandra
            deadnix
            statix
            typos
            nodePackages.prettier
          ];
          name = "dots";
          shellHook = ''
            ${self.checks.${pkgs.system}.pre-commit-check.shellHook}
          '';
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    # Official NixOS package source, using nixos's unstable branch by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
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

    systems.url = "github:nix-systems/default-linux";

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

    # disko for declarative partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    agenix = {
      # type-safe reimplementation of agenix to get a better error messages and less bugs
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Third party programs, packaged with nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:/InioX/Matugen";
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

    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    zen-browser = {
      url = "github:fufexan/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
