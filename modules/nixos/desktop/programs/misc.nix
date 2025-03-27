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

      # help manage android devices via command line
      adb.enable = true;

      # show network usage
      bandwhich.enable = true;
    };
  };
}
