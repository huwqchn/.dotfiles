{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.power;
in {
  options.my.services.power = {
    enable = mkEnableOption "Enable power management";
  };
  config = mkIf cfg.enable {
    services = {
      power-profiles-daemon = {
        enable = true;
      };
      upower.enable = true;
    };
  };
}
