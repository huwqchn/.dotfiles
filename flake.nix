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
      systems = ["aarch64-darwin" "x86_64-linux"];
      imports = [./flakes];
    };

  inputs = {
    # Official NixOS package source, using nixos's unstable branch by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
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
    nvidia-patch = {
      url = "github:keylase/nvidia-patch";
      flake = false;
    };
    openwrt-imagebuilder = {
      url = "github:astro/nix-openwrt-imagebuilder";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # treefmt = {
    #   url = "github:numtide/treefmt-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # secrets management
    agenix = {
      # type-safe reimplementation of agenix to get a better error messages and less bugs
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos wsl
    wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
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

    # matugen = {
    #   url = "github:/InioX/Matugen";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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

    # spicetify-nix
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # blender
    # blender-bin = {
    #   url = "github:edolstra/nix-warez?dir=blender";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
