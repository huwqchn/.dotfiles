{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.attrsets) mapAttrs;
  isHeadless = !config.my.desktop.enable;
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
