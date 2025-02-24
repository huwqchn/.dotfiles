{
  config,
  lib,
  ...
}: let
  shellAliases = {"top" = "btop";};
  inherit (lib) mkIf types mkOption;
  cfg = config.my.btop;
in {
  options.my.btop = {
    enable = mkOption {
      default = true;
      type = types.bool;
      description = "Enable btop";
    };
  };

  config = mkIf cfg.enable {
    home.shellAliases = shellAliases;
    programs.btop = {enable = true;};
  };
}
