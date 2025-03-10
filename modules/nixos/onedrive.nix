{
  lib,
  config,
  ...
}:
lib.my.mkModule config "onedrive" {
  services.onedrive.enable = true;
}
