{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config) my;
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.caddy;
in {
  options.my.caddy = {
    enable = mkEnableOption "Enable Caddy";
  };

  config = mkIf cfg.enable {
    environment = {
      shellAliases = {
        caddy-log = "journalctl _SYSTEMD_UNIT=caddy.service";
      };
      systemPackages = with pkgs; [custom-caddy];
    };
    services = {
      caddy = {
        enable = true;
        inherit (my) email;
        globalConfig = ''
          servers {
            trusted_proxies cloudflare {
              interval 12h
              timeout 15s
            }
          }
        '';
        package = pkgs.custom-caddy;
      };
    };
  };
}
