{
  lib,
  config,
  ...
}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkIf mkForce;
  isHeadless =
    config.my.machine.type
    == "workstation"
    || config.my.machine.type == "server"
    || config.my.machine.type == "mobile";
in {
  config = mkIf isHeadless {
    xdg = mapAttrs (_: mkForce) {
      sounds.enable = false;
      mime.enable = false;
      menus.enable = false;
      icons.enable = false;
      autostart.enable = false;
    };
  };
}
