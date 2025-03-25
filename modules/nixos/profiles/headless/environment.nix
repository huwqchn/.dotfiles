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
    # print the URL instead on servers
    environment.variables.BROWSER = "echo";
  };
}
