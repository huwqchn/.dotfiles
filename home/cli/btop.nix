{
  config,
  lib,
  ...
}: let
  shellAliases = {"top" = "btop";};
in
  lib.my.mkModuleWithOptions config "btop" {
    home.shellAliases = shellAliases;
    programs.btop = {enable = true;};
  }
