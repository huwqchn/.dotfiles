{
  lib,
  config,
  ...
}: let
  cfg = config.my.services.proxy;
  inherit (lib.modules) mkIf;
in {
  config = mkIf cfg.enable {
    services.sing-box = {
      enable = true;
    };
  };
}
