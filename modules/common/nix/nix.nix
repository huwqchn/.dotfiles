{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.attrsets) filterAttrs attrValues mapAttrs;
  inherit (lib.modules) mkForce;
  inherit (lib.types) isType;
  inherit (lib.my) ldTernary;
  flakeInputs = filterAttrs (name: value: (isType "flake" value) && (name != "self")) inputs;
  sudoers = ldTernary pkgs "@wheel" "@admin";
in {
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;
  nix = {
    # pin the registry to avoid downloading and evaluating a new nixpkgs version everytime
    # Define global flakes for this system
    # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    registry =
      (mapAttrs (_: flake: {inherit flake;}) flakeInputs)
      // {
        # https://github.com/NixOS/nixpkgs/pull/388090
        nixpkgs = mkForce {flake = inputs.nixpkgs;};
      };
    # We love legacy support (for now)
    nixPath = ldTernary pkgs (attrValues (mapAttrs (k: v: "${k}=flake:${v.outPath}") flakeInputs)) (
      mkForce (mapAttrs (_: v: v.outPath) flakeInputs)
    );
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;
    settings = {
      # these are the bare minimum settings required to get my nixos config working
      experimental-features = [
        # enables flakes, needed for this config
        "flakes"

        # enables the nix3 commands, a requirement for flakes
        "nix-command"
      ];
      # users or groups that are allowed ot do anything with the Nix daemon
      allowed-users = [sudoers];
      # users or groups that are allowed to manage the nix store
      trusted-users = [sudoers];

      # we don't want to track the registry, but we do want to allow the useage
      # of the `flake:` references, so we need to enable use-registries
      use-registries = true;
      flake-registry = "";

      # let the system decide the number of max jobs
      max-jobs = "auto";

      # build inside sandboxed environments
      # we only enable this on linux because it servirly breaks on darwin
      sandbox = pkgs.stdenv.hostPlatform.isLinux;

      # supported system features
      system-features = [
        "nixos-test"
        "kvm"
        "recursive-nix"
        "big-parallel"
      ];

      # continue building derivations even if one fails
      # this is important for keeping a nice cache of derivations, usually because I walk away
      # from my PC when building and it would be annoying to deal with nothing saved
      keep-going = true;

      # show more log lines for failed builds, as this happens alot and is useful
      log-lines = 30;

      # it's annoying to see the warning when running `nixos-rebuild switch`
      warn-dirty = false;

      # whether to accept nix configuration from a flake without prompting
      # littrally a CVE waiting to happen <https://x.com/puckipedia/status/1693927716326703441>
      accept-flake-config = false;

      # It's nice to have more http downloads when setting up
      http-connections = 50;

      # this defaults to true, however it slows down evaluation so maybe we should disable it
      # some day, but we do need it for catppuccin/nix so maybe not too soon
      allow-import-from-derivation = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;
    };
  };
}
