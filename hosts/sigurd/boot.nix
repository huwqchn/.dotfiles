{ inputs, ... }: {
  imports = [
    inputs.dedsec-grub-theme.nixosModule
  ];
  # boot
  boot = {
    kernelParams = [ "loglevel=5" "splash" "nowatchdog" ];
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;

      dedsec-theme = {
        enable = true;
        style = "wrench";
        icon = "color";
        resolution = "1440p";
      };
    };
  };
}
