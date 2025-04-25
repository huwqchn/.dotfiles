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
      QT_SCALE_FACTOR = "2";
      QT_ENABLE_HIGHDPI_SCALING = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
    };
  };
}
