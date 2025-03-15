{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (config) my;
  cfg = config.my.tailscale;
  isWorkstation = config.my.machine.type == "workstation";
in {
  options.my.tailscale = {
    enable = mkEnableOption "Enable Tailscale";
    advertiseExitNode = mkEnableOption "advertise as exit node";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; lib.optionals isWorkstation [trayscale];

    services.tailscale = {
      enable = true;
      extraUpFlags =
        [
          "--operator=${my.name}"
        ]
        ++ lib.optional cfg.advertiseExitNode "--advertise-exit-node";
      extraSetFlags =
        [
          "--operator=${my.name}"
        ]
        ++ lib.optional cfg.advertiseExitNode "--advertise-exit-node";
      # Enable caddy to acquire certificates from the tailscale daemon
      # - https://tailscale.com/blog/caddy
      permitCertUid = lib.mkIf my.caddy.enable "caddy";
      openFirewall = true;
      useRoutingFeatures = "both";
    };
  };
}
