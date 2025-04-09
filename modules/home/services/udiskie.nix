{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.services.udiskie;
in {
  options.my.services.udiskie = {enable = mkEnableOption "udiskie";};

  config = mkIf cfg.enable {
    # auto mount usb drives
    services = {udiskie.enable = true;};
  };
}
