# NOTE: ... is needed because disko passes diskoFile
{ lib
, device ? throw "Set this to your disk device, e.g. /dev/sda"
, withSwap ? false
, swapSize
# , configVars
, ...
}:
{
  disko = {
    # Do not let Disko manage fileSystems.* config for NixOS.
    # Reason is that Disko mounts partitions by GPT partition names, which are
    # easily overwritten with tools like fdisk. When you fail to deploy a new
    # config in this case, the old config that comes with the disk image will
    # not boot either.
    enableConfig = false;
    devices.disk = {
      main = {
        type = "disk";
        inherit device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              label = "BOOT";
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            root = {
              name = "root";
              label = "ROOT";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  # "@persist" = {
                  #   mountpoint = "${configVars.persistFolder}";
                  #   mountOptions = [
                  #     "compress=zstd"
                  #     "noatime"
                  #   ];
                  # };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@swap" = lib.mkIf withSwap {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "${swapSize}G";
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
