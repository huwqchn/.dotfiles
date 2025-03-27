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
  };
}
