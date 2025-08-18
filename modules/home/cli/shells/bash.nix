{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.my.bash;
in {
  options.my.bash = {
    enable = mkEnableOption "bash" // {default = true;};
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
    };
  };
}
