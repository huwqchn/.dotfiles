{
  config,
  lib,
  ...
}: let
  cfg = config.my.power;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.power = {
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
