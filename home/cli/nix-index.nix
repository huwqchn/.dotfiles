{ lib
, pkgs
, nix-index-database
, ...
}: let
  sourceCommandNotFound = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
in {
  imports = [
    nix-index-database.nixosModule.nix-index
  ];

  programs = {
    nix-index.enable = true;
    command-not-found.enable = lib.mkForce false;
    bash.intreactiveShellInit = sourceCommandNotFound;
    zsh.interactiveShellInit = sourceCommandNotFound;
    fish.interactiveShellInit = sourceCommandNotFound;
  };
}
