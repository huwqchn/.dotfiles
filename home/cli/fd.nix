{
  config,
  lib,
  ...
}:
lib.my.mkEnabledModule config "fd" {
  programs.fd = {
    enable = true;
    ignores = [".git/" ".direnv/"];
    hidden = true;
  };
}
