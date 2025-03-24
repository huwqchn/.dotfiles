{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.boot;
in {
  # How to enter setup mode - msi motherboard
  ## 1. enter BIOS via [Del] Key
  ## 2. <Advance mode> => <Settings> => <Security> => <Secure Boot>
  ## 3. enable <Secure Boot>
  ## 4. set <Secure Boot Mode> to <Custom>
  ## 5. enter <Key Management>
  ## 6. select <Delete All Secure Boot Variables>, and then select <No> for <Reboot Without Saving>
  ## 7. Press F10 to saving and reboot.
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options.my.boot.secure = mkEnableOption "secure boot";

  config = mkIf cfg.secure {
    environment.systemPackages = [
      # For debugging and troubleshooting Secure Boot.
      pkgs.sbctl
    ];

    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    # boot specification logs
    boot.bootspec.enable = true;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
