{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.my) scanPaths;
  cfg = config.my.desktop;
in {
  imports = scanPaths ./.;

  config = mkIf (cfg.enable && cfg.wayland.enable) {
    services.xserver.enable = mkDefault false;
  };
}
