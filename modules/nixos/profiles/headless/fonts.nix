{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.attrsets) mapAttrs;
  isHeadless =
    config.my.machine.type
    == "workstation"
    || config.my.machine.type == "server"
    || config.my.machine.type == "mobile";
in {
  config = mkIf isHeadless {
    # we don't need fonts on a server
    # since there are no fonts to be configured outside the console
    fonts = mapAttrs (_: mkForce) {
      packages = [];
      fontDir.enable = false;
      fontconfig.enable = false;
    };
  };
}
