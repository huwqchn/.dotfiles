{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (config.my.machine) persist;
  inherit (lib.modules) mkForce;
in {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence =
    if persist
    then {
      "/persist/${config.home.homeDirectory}" = {
        directories = [
          ".local/bin"
          ".cache/nix"
          ".cache/pre-commit"
          ".dotfiles"
          ".docker"
          ".secrets"
          "Documents"
          "Downloads"
          "Desktop"
          "Media"
          "Public"
          "Dev"
          "Misc"
        ];
        allowOther = true;
      };
    }
    else mkForce {};
}
