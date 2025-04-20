{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  cfg = config.my.theme.tokyonight;
  enable = cfg.enable && config.my.desktop.enable && isLinux;
in {
  config = mkIf enable {
    gtk.iconTheme = {
      name =
        if cfg.style == "day"
        then "Papirus-Light"
        else "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
