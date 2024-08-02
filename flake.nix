{
  description = "my NixOS flakes configuration";

  outputs = inputs: import ./systems inputs;

  # the nixConfig here only affects the flake itself, not the system configuration!
  # for more information, see:
  #     https://nixos-and-flakes.thiscute.world/nix-store/add-binary-cache-servers
  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    extra-substituters = [
      "https://nix-gaming.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # user configuration management
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprwm
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.hyprutils.follows = "hyprland/hyprutils";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.hyprutils.follows = "hyprland/hyprutils";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.hyprutils.follows = "hyprland/hyprutils";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    tailray = {
      url = "github:NotAShelf/tailray";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nightly overlay
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # for macos
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    agenix = {
      url = "github:yaxitech/ragenix";
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

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    daeuniverse.url = "github:daeuniverse/flake.nix";

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    # for colorshemes generation by wallpaper
    matugen = {
      url = "github:InioX/matugen";
      inpust.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # my wallpapers
    wallpapers = {
      url = "github:huwqchn/wallpapers";
      flake = false;
    };


    disko = {
      url = "github:nix-community/disko/v1.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inpust.flake-compat.follows = "flake-compat";
    };

    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
}
