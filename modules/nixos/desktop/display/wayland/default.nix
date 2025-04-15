{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.my) scanPaths;
  cfg = config.my.desktop;
  isWayland = cfg.type == "wayland";
in {
  imports = scanPaths ./.;

  config = mkIf (cfg.enable && isWayland) {
    services.xserver.enable = mkDefault false;
  };
}
