{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.security.apparmor;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.security.apparmor = {
    enable =
      mkEnableOption "Enable AppArmor"
      // {
        default = config.my.security.enable;
      };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      apparmor-bin-utils
      apparmor-profiles
      apparmor-parser
      libapparmor
      apparmor-kernel-patches
      apparmor-pam
      apparmor-utils
    ];

    services.dbus.apparmor = "enabled";

    security.apparmor = {
      enable = true;

      # whether to enable the AppArmor cache
      # in /var/cache/apparmor
      enableCache = true;

      # kill process that are not confined but have apparmor profiles enabled
      killUnconfinedConfinables = true;

      # packages to be added to AppArmor's include path
      packages = with pkgs; [
        apparmor-utils
        apparmor-profiles
      ];

      # apparmor policies
      policies = {
        "default_deny" = {
          enforce = false;
          enable = false;
          profile = ''
            profile default_deny /** { }
          '';
        };

        "sudo" = {
          enforce = false;
          enable = false;
          profile = ''
            ${pkgs.sudo}/bin/sudo {
              file /** rwlkUx,
            }
          '';
        };

        "nix" = {
          enforce = false;
          enable = false;
          profile = ''
            ${config.nix.package}/bin/nix {
              unconfined,
            }
          '';
        };
      };
    };
  };
}
