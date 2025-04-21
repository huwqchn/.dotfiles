{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.services.wluma;
in {
  options.my.services.wluma = {enable = mkEnableOption "wluma";};

  config = mkIf cfg.enable {
    # auto adjust the brightness of your screen based on the time of day
    services.wluma.enable = true;
  };
}
