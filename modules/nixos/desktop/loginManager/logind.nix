{
  lib,
  config,
  ...
}: let
  inherit (lib.module) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf cfg.enable {
    services.logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
      powerKey = "suspend-then-hibernate";
    };
  };
}
