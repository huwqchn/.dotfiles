{
  config,
  lib,
  ...
}: let
  shellAliases = {"top" = "btop";};
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.btop;
in {
  options.my.btop = {enable = mkEnableOption "btop";};

  config = mkIf cfg.enable {
    home.shellAliases = shellAliases;
    programs.btop = {enable = true;};
  };
}
