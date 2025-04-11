{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my.machine) isHidpi;
in {
  config = mkIf isHidpi {
    environment.sessionVariables = {
      QT_DEVICE_PIXEL_RATIO = "2";
      QT_AUTO_SCREEN_SCALE_FACTOR = "true";
    };
  };
}
