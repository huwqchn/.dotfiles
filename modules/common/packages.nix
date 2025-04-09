{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  ## add this here, cause agenix.homeManagerModule not has this option
  age.ageBin = getExe pkgs.rage;

  environment.systemPackages = with pkgs; [
    # editor
    neovim
    git
    git-lfs
    wget
    curl
    just # use Justfile to simplify nix-darwin's commands
    rsync
    cmake
    gnumake
    # darwin only apps
    coreutils
    # nix
    nix-prefetch-git
    # GNU core utilities (rewritten in rust)
    uutils-coreutils-noprefix
  ];
}
