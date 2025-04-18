{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my.machine) hasHidpi;
in {
  config = mkIf hasHidpi {
    environment.sessionVariables = {
      QT_DEVICE_PIXEL_RATIO = "2";
      QT_AUTO_SCREEN_SCALE_FACTOR = "true";
    };
  };
}
