{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.my.desktop.apps.telegram;
in {
  options.my.desktop.apps.telegram = {
    enable =
      mkEnableOption "Telegram"
      // {
        default = config.my.desktop.enable;
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # instant messaging
      telegram-desktop
    ];
  };
}
