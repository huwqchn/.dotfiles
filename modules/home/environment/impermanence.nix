{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkForce;
  persist = config.my.persistence.enable;
in {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence =
    if persist
    then {
      "/persist${config.home.homeDirectory}" = {
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
