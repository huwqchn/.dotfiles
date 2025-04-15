{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
  isXorg = cfg.type == "xorg";
in {
  config = mkIf (cfg.enable && isXorg) {
    services.xserver.excludePackages = [
      pkgs.xterm
    ];
  };
}
