{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.avizo;
in {
  options.my.avizo = {enable = mkEnableOption "avizo";};
  config = mkIf cfg.enable {
    services.avizo = {
      enable = false;
      settings = {default = {y-offset = 0.85;};};
    };
  };
}
