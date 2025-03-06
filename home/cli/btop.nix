{
  config,
  lib,
  ...
}: let
  shellAliases = {"top" = "btop";};
in
  lib.my.mkEnabledModule config "btop" {
    home.shellAliases = shellAliases;
    programs.btop = {enable = true;};
  }
