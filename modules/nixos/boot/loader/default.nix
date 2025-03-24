{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = lib.my.scanPaths ./.;
  options.my.boot.loader = mkOption {
    type = types.enum [
      "none"
      "grub"
      "systemd-boot"
    ];
    default = "grub";
    description = "The boot loader to use.";
  };
}
