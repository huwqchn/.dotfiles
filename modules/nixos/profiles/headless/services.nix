{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  isHeadless =
    config.my.machine.type
    == "workstation"
    || config.my.machine.type == "server"
    || config.my.machine.type == "mobile";
in {
  config = mkIf isHeadless {
    # a headless system should not mount any removable media
    # without explicit user action
    services.udisks2.enable = lib.modules.mkForce false;
  };
}
