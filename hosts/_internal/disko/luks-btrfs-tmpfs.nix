{
  device ?  "/dev/nvme0n1",
  sizes ? { tmp = "8G"; esp = "512M"; swap = "32G"; },
  ...
}:
{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        "size=${sizes.tmp}"
        "mode=755"
      ];
    };

    disk.main = {
      type = "disk";
      inherit device;

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = sizes.esp;
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
              ];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings = {
                allowDiscards = true;
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
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  # mount the top-level subvolume at /btr_pool
                  # it will be used by btrbk to create snapshots
                  "/" = {
                    mountpoint = "/btr_pool";
                    # btrfs's top-level subvolume, internally has an id 5
                    # we can access all other subvolumes from this subvolume.
                    mountOptions = [ "subvolid = 5" ];
                  };
                  # why use @ in btrfs subvolume names: 
                  # https://askubuntu.com/questions/987104/why-the-in-btrfs-subvolume-names
                  # https://www.reddit.com/r/btrfs/comments/11wnyoj/btrfs_what_is/
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = ["noatime"];
                  };
                  "@snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@swap" = {
                    mountpoint = "/.swap";
                    mountOptions = ["noatime"];
                    swap.swapfile.size = sizes.swap;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}