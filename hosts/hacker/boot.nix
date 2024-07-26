{
  lib,
  dedsec-grub-theme,
  ...
}: {
  imports = [
    dedsec-grub-theme.nixosModule
  ];
  # boot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;

      dedsec-theme = {
        enable = true;
	      style = "compact";
	      icon = "color";
	      resolution = "1080p";
      };
    };
  };
}
