{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  isWayland = config.my.desktop.type == "wayland" && isLinux;
  enable = config.my.desktop.notification == "avizo" && isWayland;
in {
  config = mkIf enable {
    services.avizo = {
      enable = true;
      settings.default.y-offset = 0.85;
    };
  };
}
