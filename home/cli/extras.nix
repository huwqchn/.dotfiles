{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.extras;
  # Platform-independent terminal setup
in {
  options.my.extras = {enable = mkEnableOption "extras";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Unixy tools
      sd
      moreutils # ts, etc.
      tokei
      hub # wrapper for git

      # trashing files tool
      trashy

      # Broken, https://github.com/NixOS/nixpkgs/issues/299680
      # ncdu

      # Useful for Nix development
      nixci
      nixpkgs-fmt

      # Publishing
      asciinema

      # Dev
      entr

      # Txns
      hledger
      hledger-web

      gnupg
      gnumake

      sad # CLI search and replace, just like sed, but with diff preview.
      yq-go # yaml processor https://github.com/mikefarah/yq
      hyperfine # command-line benchmarking tool
      gping # ping, but with a graph(TUI)
      doggo # DNS client for humans
      duf # Disk Usage/Free Utility - a better 'df' alternative
      du-dust # A more intuitive version of `du` in rust
      gdu # disk usage analyzer(replacement of `du`)
      ncdu

      # nix related
      #
      # it provides the command `nom` works just like `nix
      # with more details log output
      nix-output-monitor
      hydra-check # check hydra(nix's build farm) for the build status of a package
      # nix-init # generate nix derivation from url
      # https://github.com/nix-community/nix-melt
      # nix-melt # A TUI flake.lock viewer
      # https://github.com/utdemir/nix-tree
      nix-tree # A TUI to visualize the dependency graph of a nix derivation

      # productivity
      caddy # A webserver with automatic HTTPS via Let's Encrypt(replacement of nginx)
      croc # File transfer between computers securely and easily
      ncdu # analyzer your disk usage Interactively, via TUI(replacement of `du`)
      choose
      sd

      # dev
      colmena # nixos's remote deployment tool

      #db
      mongosh
      sqlite

      # embedded development
      minicom

      protobuf # protocol buffer compiler

      # Automatically trims your branches whose tracking remote refs are merged or gone
      # It's really useful when you work on a project for a long time.
      git-trim
      gitleaks

      brotab
    ];

    programs.jq.enable = true;

    home.persistence = {
      "/persist/${config.home.homeDirectory}" = {
        directories = [
          ".cache/brillo"
          ".cache/fontconfig"
          # I dont know what this is, but it's huge, so it probably useful
          ".cache/mesa_shader_cache"
          ".config/pulse"
          ".local/share/Trash"
        ];
        files = [".local/state/lesshst"];
      };
    };
  };
}
