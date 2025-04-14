{config, ...}: let
  cfg = config.my.desktop.loginManager;
in {
  services.displayManager.cosmic-greeter.enable = cfg == "cosmic-greeter";
}
