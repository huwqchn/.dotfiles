{
  lib,
  config,
  ...
}:
lib.mkIf config.my.onedrive.enable {
  services.onedrive.enable = true;
}
