{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.my.services.avizo;
in {
  options.my.services.avizo = {enable = mkEnableOption "avizo";};
  config = mkIf cfg.enable {
    services.avizo = {
      enable = true;
      settings.default.y-offset = 0.85;
    };
  };
}
