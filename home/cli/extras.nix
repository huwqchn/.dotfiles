{ pkgs, ... }:
# Platform-independent terminal setup
{
  home.packages = with pkgs; [
    # Unixy tools
    fd
    sd
    moreutils # ts, etc.
    tokei
    hub # wrapper for git

    # Broken, https://github.com/NixOS/nixpkgs/issues/299680
    # ncdu

    # Useful for Nix development
    nixci
    nixpkgs-fmt

    # Publishing
    asciinema

    # Dev
    gh
    entr

    # Txns
    hledger
    hledger-web

    gnupg
    gnumake

    sad # CLI search and replace, just like sed, but with diff preview.
    yq-go # yaml processor https://github.com/mikefarah/yq
    just # a command runner like make, but simpler
    delta # A viewer for git and diff output
    lazygit # Git terminal UI.
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

  ];

  programs = {
    jq.enable = true;
    rio.enable = true;
  };
}
