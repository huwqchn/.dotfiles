{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}: {
  nixpkgs = {config.allowUnfree = true;};
  # for security reasons, do not load neovim's user config
  # since EDITOR may be used to edit some critical files
  environment.variables.EDITOR = "nvim --clean";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;
  nix = {
    # auto upgrade nix to the unstable version
    # htitps://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/package-management/nix/default.nix#L284
    package = pkgs.nixVersions.latest;
    # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
    # discard all the default paths, and only use the one from this flake.
    nixPath = lib.mkForce ["/etc/nix/inputs"];
    # do garbage collection weekly to keep disk usage low
    # use nh clean instead
    # gc = {
    #   automatic = lib.mkDefault true;
    #   dates = lib.mkDefault "weekly";
    #   options = lib.mkDefault "--delete-older-than 7d";
    # };

    optimise.automatic = lib.mkDefault true;
    settings = {
      # enable flakes globally
      experimental-features = ["nix-command" "flakes"];
      # dont warn git tree is dirty, it't annoying.
      warn-dirty = false;
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB
      # given the users in this list the right to specify additional substituters via:
      #    1. `nixConfig.substituers` in `flake.nix`
      #    2. command line args `--options substituers http://xxx`
      trusted-users = [config.my.name];
      # substituers that will be considered before the official ones(https://cache.nixos.org)
      substituters = [
        # cache mirror located in China
        # status: https://mirror.sjtu.edu.cn/
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        # status: https://mirrors.ustc.edu.cn/status/
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

        "https://nix-community.cachix.org"
        # cuda-maintainer's cache server
        "https://cuda-maintainers.cachix.org"
      ];

      # https://github.com/NixOS/nix/issues/9574
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
      builders-use-substitutes = true;
    };
    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;
    # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    # registry.nixpkgs.flake = lib.mkForce nixpkgs;
  };

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
}
