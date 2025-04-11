{
  lib,
  config,
  ...
}: let
  cfg = config.my.services.jellyfin;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options.my.services.jellyfin = {
    enable = mkEnableOption "jellyfin";
    port = lib.mkOption {
      type = lib.types.int;
      default = 8096;
      description = "The port on which Jellyfin will listen.";
    };
  };

  config = mkIf cfg.enable {
    services.jellyfin.enable = true;

    networking.firewall = {
      allowedTCPPorts = [cfg.port];
      allowedUDPPorts = [cfg.port];
    };
  };
}
