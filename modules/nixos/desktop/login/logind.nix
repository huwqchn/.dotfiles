{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my) desktop;
in {
  config = mkIf desktop.enable {
    services.logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
      powerKey = "suspend-then-hibernate";
    };
  };
}
