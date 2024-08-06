{
  pkgs,
  config,
  ...
}: {
  # If your themes for mouse cursor, icons or windows don't load correctly,
  # try setting them with home.pointerCursor and gtk.theme,
  # which enable a bunch of compatibility options that should make the themes load in all situations.

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
  };

  # set dpi for 4k monitor
  xresourecs.properties = {
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
      name = "Cantarell";
      package = pkgs.cantarell-fonts;
      size = 11;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Tokyonight-Dark-BL";
      package = pkgs.tokyonight-gtk-theme;
    };

    # cursorTheme = {
    #   name = "Bibata-Modern";
    #   paackage = pkgs.bibata-cursors;
    #   size = 0;
    # };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
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
}
