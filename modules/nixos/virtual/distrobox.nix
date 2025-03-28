{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.my.virtual.distrobox;
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.virtual.distrobox = {
    enable =
      mkEnableOption "Enable distrobox"
      // {
        default = config.my.virtual.enable;
      };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      distrobox
    ];

    # if distrobox is enabled, update it periodically
    systemd.user = {
      timers."distrobox-update" = {
        enable = true;
        wantedBy = ["timers.target"];
        timerConfig = {
          OnBootSec = "1h";
          OnUnitActiveSec = "1d";
          Unit = "distrobox-update.service";
        };
      };

      services."distrobox-update" = {
        enable = true;
        script = ''
          ${pkgs.distrobox}/bin/distrobox upgrade --all
        '';
        serviceConfig = {
          Type = "oneshot";
        };
      };
    };
  };
}
