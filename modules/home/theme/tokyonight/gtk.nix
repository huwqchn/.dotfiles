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
    # gkt's theme settings, generate files:
    #   1. ~/.gtkrc-2.0
    #   2. ~/.config/gtk-3.0/settings.ini
    #   3. ~/.config/gtk-4.0/settings.ini
    gtk = {
      enable = true;

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

      font = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
        size = 11;
      };

      theme = {
        name = "Tokyonight-Dark-BL";
        package = pkgs.tokyonight-gtk-theme;
      };
    };
  };
}
