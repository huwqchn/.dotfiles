{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.my) ldTernary;
  inherit (config.my) desktop;
  cfg = config.my.services.wluma;
in {
  options.my.services.wluma = {
    enable =
      mkEnableOption "wluma"
      // {
        default = ldTernary pkgs desktop.enable false;
      };
  };

  config = mkIf cfg.enable {
    # auto adjust the brightness of your screen based on the time of day
    services.wluma.enable = true;
  };
}
