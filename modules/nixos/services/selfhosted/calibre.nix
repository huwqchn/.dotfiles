{ lib, config, ... }: let
  cfg = config.my.service.cailbre;
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.service.calibre = {
    enable = mkEnableOption "calibre";
    port = lib.mkOption {
      type = lib.types.int;
      default = 8080;
      description = "The port to listen on";
    };
  };

  config = mkIf cfg.enable {
    services.calibre-server.enable = true;

    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
