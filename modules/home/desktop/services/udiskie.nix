{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.my) ldTernary;
  inherit (config.my) desktop;
  cfg = config.my.services.udiskie;
in {
  options.my.services.udiskie = {
    enable =
      mkEnableOption "udiskie"
      // {
        default = ldTernary pkgs desktop.enable false;
      };
  };

  config = mkIf cfg.enable {
    # auto mount usb drives
    services.udiskie.enable = true;
  };
}
