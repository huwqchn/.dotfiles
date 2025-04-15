{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.my.machine) persist;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) optionalString concatLines;
  inherit (lib.attrsets) attrValues;
in {
  imports = [inputs.impermanence.nixosModules.impermanence];

  config = mkIf persist {
    fileSystems."/persist".neededForBoot = true; # required by impermanence
    fileSystems."/var/log".neededForBoot = true; # required by nixos
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

    # NOTE: impermanence only mounts the directory/file list below to /persist
    # If the directory/file already exists in the root filesystem, you should
    # move those files/directories to /persistent first!
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/secureboot"
        "/etc/nixos"
        "/etc/nix"
        "/etc/NetworkManager/system-connections"
        "/etc/adjtime"
        "/var/db/sudo"
        # maybe we need more fine-grained
        "/var/lib"
      ];
      files = [
        "/etc/machine-id"
        # "/etc/ssh/ssh_host_ed25519_key"
        # "/etc/ssh/ssh_host_ed25519_key.pub"
        # "/etc/ssh/ssh_host_rsa_key"
        # "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };

    system.activationScripts = {
      # NOTE: this is for nixos-anywhere to install nixos on first boot
      persistent-init = {
        deps = ["persistence-home" "persistence-ssh"];
        text = let
          persistence = config.environment.persistence."/persist";
          cpDir = dir: let
            dest = "/persist${dir}";
          in ''
            if [ -d "${dir}" ]; then
              echo "Copying directory ${dir} to ${dest}"
              mkdir -p "$(dirname "${dest}")"
              cp -a "${dir}" "${dest}"
            fi
          '';

          cpFile = file: let
            dest = "/persist${file}";
          in ''
            if [ -f "${file}" ]; then
              echo "Copying file ${file} to ${dest}"
              mkdir -p "$(dirname "${dest}")"
              cp -a "${file}" "${dest}"
            fi
          '';
        in ''
          #!/bin/sh
          if [ ! -f /persist/.init ]; then
            echo "Initializing persistent directories and files ..."

            echo "Copying directories to /persist:"
            ${concatLines (map cpDir persistence.directories)}

            echo "Copying files to /persist:"
            ${concatLines (map cpFile persistence.files)}

            touch /persist/.init
            echo "Persistent initialization complete."
          else
            echo "/persist/.init exists, skipping persistent initialization."
          fi
        '';
      };
      # NOTE: we use nixos-anywhere with copy-host-keys arg so we need copy these ssh keys to /persist
      persistent-ssh.text = let
        sshKeys = [
          {
            path = "/etc/ssh/ssh_host_ed25519_key";
            mode = "700";
          }
          {
            path = "/etc/ssh/ssh_host_ed25519_key.pub";
            mode = "755";
          }
          {
            path = "/etc/ssh/ssh_host_rsa_key";
            mode = "700";
          }
          {
            path = "/etc/ssh/ssh_host_rsa_key.pub";
            mode = "755";
          }
        ];
        cpSSHKeys = key: let
          dest = "/persist${key.path}";
        in ''
          if [ -f "${key.path}" ]; then
            echo "Copying ${key.path} to ${dest} with mode ${key.mode}"
            mkdir -p "$(dirname "${dest}")"
            cp -a "${key.path}" "${dest}"
            chmod ${key.mode} "${dest}"
          fi
        '';
      in ''
        #!/bin/sh
        if [ ! -f /persist/etc/ssh/.init ]; then
          echo "Initializing persistent SSH keys..."
          ${lib.concatLines (map cpSSHKeys sshKeys)}
          touch /persist/etc/ssh/.init
          echo "Persistent SSH keys initialization complete."
        else
          echo "Persistent SSH keys already initialized, skipping."
        fi
      '';
      persistent-home.text = let
        mkHomePersist = user:
          optionalString user.createHome ''
            mkdir -p /persist${user.home}
            chown ${user.name}:${user.group} /persist${user.home}
            chmod ${user.homeMode} /persist${user.home}
          '';
        users = attrValues config.users.users;
      in
        concatLines (map mkHomePersist users);
    };

    # for uesr level persistence
    programs.fuse.userAllowOther = true;
  };
}
