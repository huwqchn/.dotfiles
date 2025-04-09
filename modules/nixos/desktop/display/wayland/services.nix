{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable) {
    systemd.services.seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${getExe pkgs.seatd} -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
