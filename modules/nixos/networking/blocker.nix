{
  lib,
  config,
  ...
}: let
  isServer = config.my.machine.type == "server";
  inherit (lib) mkIf;
in {
  config = mkIf (!isServer) {
    networking.stevenblack = {
      enable = true;
      block = [
        "fakenews"
        "gambling"
        "porn"
        "social"
      ];
    };
  };
}
