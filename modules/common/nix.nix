{
  inputs,
  config,
  pkgs,
  self,
  ...
}: {
  # Global nixpkgs configuration. This is ignored if nixpkgs.pkgs is set
  # which is a case that should be avoided. Everything that is set to configure
  # nixpkgs must go here.
  nixpkgs = {
    # Configuration reference:
    # <https://nixos.org/manual/nixpkgs/unstable/#chap-packageconfig>
    config = {
      # Allow broken packages to be built. Setting this to false means packages
      # will refuse to evaluate sometimes, but only if they have been marked as
      # broken for a specific reason. At that point we can either try to solve
      # the breakage, or get rid of the package entirely.
      allowBroken = false;
      allowUnsupportedSystem = true;

      # Really a pain in the ass to deal with when disabled. True means
      # we are able to build unfree packages without explicitly allowing
      # each unfree package.
      allowUnfree = true;

      # Default to none, add more as necessary. This is usually where
      # electron packages go when they reach EOL.
      permittedInsecurePackages = [];

      # Nixpkgs sets internal package aliases to ease migration from other
      # distributions easier, or for convenience's sake. Even though the manual
      # and the description for this option recommends this to be true
      allowAliases = true;

      # Enable parallel building by default. This, in theory, should speed up building
      # derivations, especially rust ones. However setting this to true causes a mass rebuild
      # of the *entire* system closure, so it must be handled with proper care.
      enableParallelBuildingByDefault = false;

      # List of derivation warnings to display while rebuilding.
      #  See: <https://github.com/NixOS/nixpkgs/blob/master/pkgs/stdenv/generic/check-meta.nix>
      # NOTE: "maintainerless" can be added to emit warnings
      # about packages without maintainers but it seems to me
      # like there are more packages without maintainers than
      # with maintainers, so it's disabled for the time being.
      showDerivationWarnings = [];
    };
    overlays = builtins.attrValues self.overlays;
  };
  # for security reasons, do not load neovim's user config
  # since EDITOR may be used to edit some critical files
  environment.variables.EDITOR = "nvim --clean";

  environment.etc."nixos/configuration.nix".source = pkgs.writeText "configuration.nix" ''
    assert builtins.trace "This is a dummy config, please deploy via the flake!" false;
    { }
  '';

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;
  nix = {
    settings = {
      # these are the bare minimum settings required to get my nixos config working
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      allowed-users = ["@wheel"];
      trusted-users = ["root" config.my.name];
      # given the users in this list the right to specify additional substituters via:
      #    1. `nixConfig.substituers` in `flake.nix`
      #    2. command line args `--options substituers http://xxx`
      # substituers that will be considered before the official ones(https://cache.nixos.org)
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];

      # more cores for faster builds
      cores = 5;

      # it's annoying to see the warning when running `nixos-rebuild switch`
      warn-dirty = false;

      # It's nice to have more http downloads when setting up
      http-connections = 50;
    };
    extraOptions = ''
      builders-use-substitutes = true
      flake-registry = /etc/nix/registry.json
    '';
    nixPath = ["nixpkgs=/run/current-system/nixpkgs"];
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    distributedBuilds = true;
    # Define global flakes for this system
    # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    registry.nixpkgs.flake = inputs.nixpkgs;
    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;
  };
}
