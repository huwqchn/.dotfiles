{
  lib,
  config,
  ...
}: let
  cfg = config.my.services.calibre;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) int;
in {
  options.my.services.calibre = {
    enable = mkEnableOption "calibre";
    port = mkOption {
      type = int;
      default = 8080;
      description = "The port to listen on";
    };
  };

  config = mkIf cfg.enable {
    services.calibre-server.enable = true;

    networking.firewall.allowedTCPPorts = [cfg.port];
  };
}
