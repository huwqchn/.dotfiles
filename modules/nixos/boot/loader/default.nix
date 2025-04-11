{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
in {
  imports = lib.my.scanPaths ./.;
  options.my.boot.loader = mkOption {
    type = enum [
      "none"
      "grub"
      "systemd-boot"
    ];
    default = "grub";
    description = "The boot loader to use.";
  };
}
