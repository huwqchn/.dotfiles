{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
  isWayland = cfg.type == "wayland";
in {
  config = mkIf (cfg.enable && isWayland) {
    programs.xwayland.enable = true;
  };
}
