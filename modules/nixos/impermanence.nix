{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.persist;
in {
  imports = [inputs.impermanence.nixosModules.impermanence];

  config = mkIf cfg.enable {
    environment.systemPackages = [
      # `sudo ncdu -x /`
      pkgs.ncdu
    ];

    # There are two ways to clear the root filesystem on every boot:
    ##  1. use tmpfs for /
    ##  2. (btrfs/zfs only)take a blank snapshot of the root filesystem and revert to it on every boot via:
    ##     boot.initrd.postDeviceCommands = ''
    ##       mkdir -p /run/mymount
    ##       mount -o subvol=/ /dev/disk/by-uuid/UUID /run/mymount
    ##       btrfs subvolume delete /run/mymount
    ##       btrfs subvolume snapshot / /run/mymount
    ##     '';
    #
    #  See also https://grahamc.com/blog/erase-your-darlings/

    # NOTE: impermanence only mounts the directory/file list below to /persistent
    # If the directory/file already exists in the root filesystem, you should
    # move those files/directories to /persistent first!
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = ["/etc/NetworkManager/system-connections" "/var/lib"];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
    programs.fuse.userAllowOther = true;

    system.activationScripts.persistent-dirs.text = let
      mkHomePersist = user:
        lib.optionalString user.createHome ''
          mkdir -p /persist/${user.home}
          chown ${user.name}:${user.group} /persist/${user.home}
          chmod ${user.homeMode} /persist/${user.home}
        '';
      users = lib.attrValues config.users.users;
    in
      lib.concatLines (map mkHomePersist users);
  };
}
