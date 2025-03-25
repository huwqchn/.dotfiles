{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;
  cfg = config.my.security.tor;
in {
  options.my.security.tor = {
    enable =
      mkEnableOption "Enable Tor"
      // {
        default = desktop.enable;
      };
  };

  config = mkIf cfg.enable {
    services.tor = {
      enable = true;
      client.enable = true;
      client.dns.enable = true;
      torsocks.enable = true;
    };
  };
}
