{
  config,
  lib,
  ...
}: let
  cfg = config.my.fuck;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.fuck = {
    enable = mkEnableOption "fuck";
  };

  config = mkIf cfg.enable {
    programs.pay-respects = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      options = [
        "--alias"
        "fuck"
      ];
    };
  };
}
