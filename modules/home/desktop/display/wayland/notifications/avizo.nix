{
  config,
  lib,
  ...
}: let
  inherit (lib.my) isWayland;
  inherit (lib.modules) mkIf;
  enable = config.my.desktop.notification == "avizo" && isWayland config;
in {
  config = mkIf enable {
    services.avizo = {
      enable = true;
      settings.default.y-offset = 0.85;
    };
  };
}
