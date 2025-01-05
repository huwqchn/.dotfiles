{
  config,
  lib,
  ...
}:
lib.my.mkModule config "power" {
  services = {
    power-profiles-daemon = {
      enable = true;
    };
    upower.enable = true;
  };
}
