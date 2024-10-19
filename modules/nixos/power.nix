{
  config,
  mylib,
  ...
}:
mylib.mkModule config "power" {
  services = {
    power-profiles-daemon = {
      enable = true;
    };
    upower.enable = true;
  };
}
