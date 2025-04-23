{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkForce mkIf;
  inherit (lib.meta) getExe';
  persist = config.my.persistence.enable;
  fusermount' = getExe' pkgs.fuse "fusermount";
  findmnt' = lib.getExe' pkgs.util-linux "findmnt";
in {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home = {
    persistence =
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

    activation = mkIf persist {
      cleanup-dead-fuse = lib.hm.dag.entryBefore ["persistence-init"] ''
        for mp in $(${findmnt'} -t fuse.* -n -o TARGET); do
          ${fusermount'} -uz "$mp" || true
        done
      '';
    };
  };
}
