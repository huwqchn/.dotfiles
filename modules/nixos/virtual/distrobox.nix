{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (lib.meta) getExe';
  cfg = config.my.virtual.distrobox;
  distrobox' = getExe' pkgs.distrobox "distrobox";
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
          ${distrobox'} upgrade --all
        '';
        serviceConfig = {
          Type = "oneshot";
        };
      };
    };
  };
}
