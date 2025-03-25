{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    programs = {
      # dconf is a low-level configuration system.
      # we neet it to interact with gtk
      dconf.enable = true;

      # gnome's keyring manager
      seahorse.enable = true;

      # networkmanager tray uility, pretty useful actually
      nm-applet.enable = config.programs.waybar.enable;

      # help manage android devices via command line
      adb.enable = true;

      # show network usage
      bandwhich.enable = true;
    };
  };
}
