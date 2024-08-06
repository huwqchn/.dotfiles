{ pkgs, ... }:

# Platform-independent terminal setup
{
  home.packages = with pkgs; [
    # Unixy tools
    ripgrep
    fd
    sd
    moreutils # ts, etc.
    tokei

    # Broken, https://github.com/NixOS/nixpkgs/issues/299680
    # ncdu

    # Useful for Nix development
    nixci
    nixpkgs-fmt
    just

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
    nix-index # A small utility to index nix store paths
    nix-init # generate nix derivation from url
    # https://github.com/nix-community/nix-melt
    nix-melt # A TUI flake.lock viewer
    # https://github.com/utdemir/nix-tree
    nix-tree # A TUI to visualize the dependency graph of a nix derivation

    # productivity
    caddy # A webserver with automatic HTTPS via Let's Encrypt(replacement of nginx)
    croc # File transfer between computers securely and easily
    ncdu # analyzer your disk usage Interactively, via TUI(replacement of `du`)
    choose
    sd
  ];

  programs = {
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      # do not enable aliases in nushell!
      enableNushellIntegration = false;
      git = true;
      icons = true;
    };
    # a cat(1) clone with syntax highlighting and Git integration.
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-mocha";
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-night";
        theme_background = false; # make btop transparent
      };
    };
    fzf.enable = true;
    zoxide.enable = true;
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config.global = {
        hide_env_diff = true;
      };
    };
    # nix-index.enable = true;
    # nix-index-database.comma.enable = true;
    jq.enable = true;
    rio.enable = true;
  };
}
