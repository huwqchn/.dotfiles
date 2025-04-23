{
  inputs,
  lib,
  config,
  ...
}: let
  persist = config.my.persistence.enable;
  inherit (lib.modules) mkForce mkIf;
  cleanupDeadFUSE = {
    name = "cleanup-dead-fuse";
    text = ''
      for mp in $(findmnt -t fuse.* -n -o TARGET); do
        fusermount -uz "$mp" || true
      done
    '';
  };
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

  home.activation = mkIf persist (
    lib.hm.dag.before ["persistence-init"] cleanupDeadFUSE
  );
}
