{
  lib,
  config,
  ...
}: let
  inherit (lib.my) scanPaths;
  inherit (lib.modules) mkIf mkForce;
  inherit (config.my.machine) type;
  isHeadless = type == "wsl" || type == "server" || type == "mobile";
in {
  imports = scanPaths ./.;

  config = mkIf isHeadless {
    my.desktop.enable = mkForce false;
    hm.my.desktop.enable = mkForce false;
  };
}
