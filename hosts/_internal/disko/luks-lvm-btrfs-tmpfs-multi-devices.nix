# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
# --mode disko /tmp/disko.nix \
# --arg devices '[ "/dev/nvme0n1" ]' \
# --arg sizes '{ swap = "8G"; esp = "512M"; }' \
# --arg lib '<nixpkgs/lib' \

# sudo nixos-generate-config \
#   --no-filesystems --root /mnt
{
  devices ? [ "nvme0n1" ],
  sizes ? {
    swap = "32G";
    esp = "512M";
  },
  lib,
  ...
}: let
  zipRange = lst: lib.lists.zipListsWith (device: deviceIndex: {inherit device deviceIndex;}) (lib.lists.range 0 ((builtins.length lst) - 1)) lst;
in {
  disko.devices = {
    disk = builtins.listToAttrs (builtins.map ({device, deviceIndex}: {
      name = device;
      value = {
        type = "disk";
        inherit device;
        content = {
          type = "gpt";
          partitions = {
            ESP = lib.mkIf (deviceIndex == 0) {
              priority = 1;
              size = sizes.esp;
              type = "EF00";
              label = "boot";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "default" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted${deviceIndex}";
                settings = {
                  allowDiscards = true; # SSD optimization
                  bypassWorkqueues = true; # SSD optimization
                };
                # encrypt the root partition with luks2 and argon2id, will prompt for a passphrase, which will be used to unlock the partition.
                # cryptsetup luksFormat
                extraFormatArgs = [
                  "--type luks2"
                  "--cipher aes-xts-plain64"
                  "--hash sha512"
                  "--iter-time 5000"
                  "--key-size 256"
                  "--pbkdf argon2id"
                  # use true random data from /dev/random, will block until enough entropy is available
                  "--use-random"
                ];
                extraOpenArgs = [
                  "--timeout 10"
                ];
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    }) (zipRange devices));
    lvm_vg.pool = {
      type = "lvm_vg";
      lvs = {
        # swap = {
        #   name = "swap";
        #   size = swapSize;
        #   content = {
        #     type = "swap";
        #     resumeDevice = true; # resume from hiberation from this device
        #   };
        # };
        nixos = {
          # Uses different format for specifying size
          # Based on `lvcreate` arguments
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ]; # Override existing filesystem
            # Subvolumes must set a mountpoint in order to be mounted
            # unless its parent is mounted
            subvolumes = let
              mountOptions = [
                "compress=zstd"
                "noatime"
                "nodiratime"
                "discard"
                "nofail"
              ];
            in {
             # mount the top-level subvolume at /btr_pool
              # it will be used by btrbk to create snapshots
              "/" = {
                mountpoint = "/btr_pool";
                # btrfs's top-level subvolume, internally has an id 6
                # we can access all other subvolumes from this subvolume.
                mountOptions = [ "subvolid = 6" ];
              };
              "@nix" = {
                mountOptions = [ "subvol=nix" ] ++ mountOptions;
                mountpoint = "/nix";
              };
              "@log" = {
                inherit mountOptions;
                mountpoint = "/var/log";
              };
              "@tmp" = {
                mountpoint = "/tmp";
                mountOptions = [ "noatime" ];
              };
              "@persist" = {
                mountOptions = [ "subvol=persist" ] ++ mountOptions;
                mountpoint = "/persist";
              };
              "@snapshots" = {
                mountOptions = [ "subvol=snapshots" ] ++ mountOptions;
                mountpoint = "/.snapshots";
              };
              "@swap" = {
                mountpoint = "/.swapvol";
                mountOptions = [ "noatime" ];
                swap.swapfile.size = sizes.swap;
              };
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        # set mode to 755, otherwise systemd will set it to 777, which cause problems.
        # relatime: Update inode access times relative to modify or change time.
        "mode=755"
      ];
    };
  };
  # fileSystems."/persist".neededForBoot = true; # required by impermanence
  # fileSystems."/var/log".neededForBoot = true; # required by nixos
}
