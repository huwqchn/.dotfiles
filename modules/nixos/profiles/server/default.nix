{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (config.my) machine;
in {
  config = mkIf (machine.type == "server") {
    time.timeZone = mkForce "UTC";

    garden = {
      # I still want the nvd diff from rebuilding the servers so lets enable that
      system.activation.diff.enable = true;
    };
  };
}
