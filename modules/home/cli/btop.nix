{
  config,
  lib,
  ...
}: let
  shellAliases = {"top" = "btop";};
  cfg = config.my.btop;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.btop = {
    enable = mkEnableOption "btop";
  };
  config = mkIf cfg.enable {
    home.shellAliases = shellAliases;
    programs.btop = {enable = true;};
  };
}
