{
  config,
  lib,
  ...
}: let
  shellAliases = {"top" = "btop";};
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.btop;
in {
  options.my.btop = {enable = mkEnableOption "btop" // {default = true;};};

  config = mkIf cfg.enable {
    home.shellAliases = shellAliases;
    programs.btop = {enable = true;};
  };
}
