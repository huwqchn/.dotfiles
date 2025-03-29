{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.dell-xps-15-9560-nvidia
    ../common/disko/luks-btrfs-tmpfs.nix
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  my = {
    boot = {
      secureBoot = false;
      tmpOnTmpfs = true;
      enableKernelTweaks = true;
      loadRecommendedModules = true;
      plymouth.enable = true;

      initrd = {
        enableTweaks = true;
        optimizeCompressor = true;
      };

      fs = [
        "ext4"
        "btrfs"
        "xfs"
        "ntfs"
        "fat"
        "vfat"
        "exfat"
      ];
    };
    yubikey.enable = true;
    video.enable = true;
    btrbk.enable = true;
    zram.enable = true;
    game.enable = false;
    security.enable = true;
    services = {
      onedrive.enable = true;
      printer.enable = true;
    };
    desktop = {
      enable = true;
      wayland.enable = true;
      default = "hyprland";
    };
    virtual.enable = true;
    machine = {
      type = "laptop";
      cpu = "intel";
      gpu = "nvidia";
      hasSound = true;
      hasBluetooth = true;
      hasPrinter = false;
      hasTPM = false;
      isHidpi = true;
      persist = true;
    };
  };
}
