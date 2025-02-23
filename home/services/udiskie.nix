{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.udiskie;
in {
  options.my.udiskie = {enable = mkEnableOption "udiskie";};

  config = mkIf cfg.enable {
    # auto mount usb drives
    services = {udiskie.enable = true;};
  };
}
