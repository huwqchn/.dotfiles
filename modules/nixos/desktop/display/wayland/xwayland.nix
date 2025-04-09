{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable) {
    programs.xwayland.enable = true;
  };
}
