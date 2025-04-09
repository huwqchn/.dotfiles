{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr str;
  cfg = config.my.boot;
in {
  imports = [
    inputs.dedsec-grub-theme.nixosModule
  ];

  options.my.boot.grub = {
    device = mkOption {
      type = nullOr str;
      default = "nodev";
      description = "The device to use for the GRUB bootloader.";
    };
    style = mkOption {
      type = str;
      default = "wrench";
      description = "The style to use for the GRUB bootloader.";
    };
  };

  config = mkIf (cfg.loader == "grub") {
    boot.loader.grub = {
      enable = mkDefault true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      enableCryptodisk = mkDefault false;
      inherit (cfg.grub) device;
      dedsec-theme = {
        enable = true;
        inherit (cfg.grub) style;
        icon = "color";
        resolution = "1440p";
      };
    };
  };
}
