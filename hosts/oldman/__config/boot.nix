{ dedsec-grub-theme, ... }: {
  imports = [
    dedsec-grub-theme.nixosModule
  ];
  # boot
  boot = {
    kernelParams = [ "loglevel=5" "splash" "nowatchdog" ];
    loader = {
      systemd-boot = {
        enable = false;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/EFI";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;

        dedsec-theme = {
          enable = true;
          style = "wrench";
          icon = "color";
          resolution = "1440p";
        };
      };
    };
  };
}
