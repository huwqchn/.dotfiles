{
  impermanence,
  pkgs,
  ...
}: {
  imports = [
    impermanence.nixosModules.impermanence
  ];

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

  # NOTE: impermanence is only mounts the directory/file list below to /persistent
  # if the directory/file already exists in the root filesystem, you should
  # move those files/directories to /persistent first!
  environment.persistence."/persistent" = {
    # sets the mount option x-gvfs-hide on all the bind mounts
    # to hide them from the file manager
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      "/etc/nix/inputs"
      "/etc/agenix"

      "/var/log"
      "/var/lib"
    ];
    files = [
      "/etc/machine-id"
    ];

    # the following directories will be passed to /persistent/home/$USER
    users.johnson = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "Documents"
        "OneDrive"
        "Workspace"
        "Projects"

        "tmp"
        ".dotfiles"
        ".config"
        ".local/share"
        ".local/state"
        ".steam"
        ".vscode"
        {
          directory = ".docker";
          mode = "0700";
        }
        {
          directory = ".kube";
          mode = "0700";
        }

        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".mozilla"

        # language package managers
        ".npm"
        ".conda"
        "go"
      ];
      files = [
        ".condarc"
      ];
    };
  };
}
