{
  description = "My NixOS flakes configuration makes me feel like the world is my oyster";

  outputs = inputs @ {
    flake-parts,
    home-manager,
    ...
  }: let
    lib =
      inputs.nixpkgs.lib.extend
      (final: _: {my = import ./lib {lib = final;};} // home-manager.lib);
    specialArgs = {inherit lib;};
  in
    flake-parts.lib.mkFlake {inherit inputs specialArgs;} {
      debug = true;
      systems = import inputs.systems;
      imports = [./flakes];
    };

  inputs = {
    # Official NixOS package source, using nixos's unstable branch by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    systems = {url = "github:nix-systems/default";};

    flake-compat = {url = "github:edolstra/flake-compat";};

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # a flake-parts module to config nix flakes devshell
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    # best way to config nix format
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: use this on my android phone future, I don't have a android phone yet
    droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # TODO: use this on my raspberry pi future
    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix?ref=v0.4.1";

    # nixos wsl
    wsl = {
      url = "github:nix-community/NixOS-WSL?ref=main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    # darwin configuration
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # make homebrew reproducible
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # persistent
    impermanence.url = "github:nix-community/impermanence";

    # secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvidia-patch = {
      url = "github:keylase/nvidia-patch";
      flake = false;
    };

    # TODO: how to use this???
    # srvos = {
    #   url = "github:nix-community/srvos";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # generate networking topology images
    nix-topology = {
      url = "github:oddlama/nix-topology";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    openwrt-imagebuilder = {
      url = "github:astro/nix-openwrt-imagebuilder";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    # for gaming
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # it's need by ags
    matugen = {
      url = "github:InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # wayland simple runner
    anyrun = {
      url = "github:fufexan/anyrun/launch-prefix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
      };
    };

    # haumea = {
    #   url = "github:nix-community/haumea/v0.2.2";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # disko for declarative partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # this is a tool to install nixos
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        disko.follows = "disko";
      };
    };

    # remote deploy tool
    deploy-rs.url = "github:serokell/deploy-rs";

    # secrets management
    agenix = {
      url = "github:yaxitech/ragenix";
      # inputs.home-manager.follows = "home-manager";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # rekey make agenix so easy to use
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        devshell.follows = "devshell";
        flake-parts.follows = "flake-parts";
        pre-commit-hooks.follows = "pre-commit-hooks";
        treefmt-nix.follows = "treefmt";
      };
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Generate configs
    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Third party programs, packaged with nix
    # firefox-addons = {
    #   url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    programs-sqlite.url = "github:wamserma/flake-programs-sqlite";

    # catppuccin.url = "github:catppuccin/nix";

    # my own wallpapers
    # this wallpaper is too big
    # wallpapers = {
    #   url = "github:huwqchn/wallpapers";
    #   flake = false;
    # };

    # hyprwm
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };

    # this grub theme is cool
    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nightly overlay
    # neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    # emacs overlay
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify-nix
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # manager vencord by nix
    nixcord.url = "github:kaylorben/nixcord";

    # apple fonts
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen browser
    zen = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Shaders for ghostty terminal
    ghostty-shaders = {
      url = "github:hackr-sh/ghostty-shaders";
      flake = false;
    };
  };
}
