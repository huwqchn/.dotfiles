{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.theme.tokyonight;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  enable = cfg.enable && config.my.desktop.enable && isLinux;
in {
  config = mkIf enable {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        package = pkgs.catppuccin-kvantum;
        name = "Kvantum";
      };
    };
  };
}
