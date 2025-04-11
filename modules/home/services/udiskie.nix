{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.services.udiskie;
in {
  options.my.services.udiskie = {enable = mkEnableOption "udiskie";};

  config = mkIf cfg.enable {
    # auto mount usb drives
    services = {udiskie.enable = true;};
  };
}
