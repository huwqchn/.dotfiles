{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.my.security;
in {
  config = mkIf cfg.enable {
    security.virtualisation = {
      #  flush the L1 data cache before entering guests
      flushL1DataCache = "always";
    };
  };
}
