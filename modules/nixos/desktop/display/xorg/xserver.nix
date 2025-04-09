{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.xorg.enable) {
    services.xserver.excludePackages = [
      pkgs.xterm
    ];
  };
}
