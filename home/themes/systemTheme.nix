{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (pkgs.stdenv) isLinux;
  inherit (config.my) desktop;
in {
  config = mkIf (desktop.enable && isLinux) {
    # If your themes for mouse cursor, icons or windows don't load correctly,
    # try setting them with home.pointerCursor and gtk.theme,
    # which enable a bunch of compatibility options that should make the themes load in all situations.

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = lib.mkForce pkgs.bibata-cursors;
      name = lib.mkForce "Bibata-Modern-Ice";
      size = lib.mkForce 24;
    };
    dconf.settings."org/gnome/desktop/interface".font-name =
      lib.mkForce "Cantarell";

    # set dpi for 4k monitor
    xresources.properties = {
      # dpi for Xorg.s font
      "Xft.dpi" = 192;
      # or set a generic dpi
      "*.dpi" = 192;

      # These might also be useful depending on your monitor and personal preferences.
      "Xft.autohint" = 0;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
    };

    # gkt's theme settings, generate files:
    #   1. ~/.gtkrc-2.0
    #   2. ~/.config/gtk-3.0/settings.ini
    #   3. ~/.config/gtk-4.0/settings.ini
    gtk = {
      enable = true;

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

      font = {
        name = mkForce "Cantarell";
        package = mkForce pkgs.cantarell-fonts;
        size = mkForce 11;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
        name = mkForce "Tokyonight-Dark-BL";
        package = mkForce pkgs.tokyonight-gtk-theme;
      };

      # cursorTheme = {
      #   name = "Bibata-Modern";
      #   package = pkgs.bibata-cursors;
      #   size = 0;
      # };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        package = pkgs.catppuccin-kvantum;
        name = "Kvantum";
      };
    };

    # xdg.configFile = {
    #   "Kvantum/kvantum.kvconfig".text = ''
    #     [General]
    #     theme=GraphiteNordDark
    #   '';
    #
    #   "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
    # };
  };
}
