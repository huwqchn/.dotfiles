{config, ...}: let
  inherit (config.my.desktop) loginManager;
in {
  services.displayManager.cosmic-greeter.enable = loginManager == "cosmic-greeter";
}
