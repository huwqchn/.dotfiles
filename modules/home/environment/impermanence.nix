{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkForce mkIf;
  inherit (lib.meta) getExe' getExe;
  persist = config.my.persistence.enable;
  fusermount' = getExe' pkgs.fuse "fusermount";
  gawk' = getExe pkgs.gawk;
  umount' = lib.getExe' pkgs.util-linux "umount";
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
      cleanup-dead-fuse = lib.hm.dag.entryBefore ["createAndMountPersistentStoragePaths"] ''
        for mp in $(${gawk'} '/fuse/ {print $2}' /proc/mounts); do
          if ! ls "$mp" >/dev/null 2>&1; then
            echo "Unmounting dead FUSE mount: $mp"
            ${fusermount'} -uz "$mp" 2>/dev/null || ${umount'} -l "$mp" 2>/dev/null
          fi
        done
      '';
    };
  };
}
