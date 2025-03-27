{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.apps.telegram;
in {
  options.my.apps.telegram = {
    enable =
      mkEnableOption "Telegram"
      // {
        default = config.my.apps.enable;
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # instant messaging
      telegram-desktop
    ];
  };
}
