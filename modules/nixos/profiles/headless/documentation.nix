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
    documentation = mapAttrs (_: mkForce) {
      enable = false;
      dev.enable = false;
      doc.enable = false;
      info.enable = false;
      nixos.enable = false;
      man = {
        enable = false;
        generateCaches = false;
        man-db.enable = false;
        mandoc.enable = false;
      };
    };
  };
}
