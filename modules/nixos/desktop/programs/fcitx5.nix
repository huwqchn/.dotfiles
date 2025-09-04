{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.my) isWayland;
  isWayland' = isWayland config;
  cfg = config.my.desktop.fcitx5;
in {
  options.my.desktop.fcitx5 = {
    enable =
      mkEnableOption "Enable fcitx5 input method"
      // {
        default = config.my.desktop.enable;
      };
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          rime-data
          fcitx5-fluent
          fcitx5-rime
          fcitx5-gtk
          fcitx5-configtool #if having issues with qt compatibility, run fcitx5-config-qt
          fcitx5-chinese-addons
          fcitx5-mozc
          fcitx5-pinyin-moegirl
          fcitx5-pinyin-zhwiki
          libsForQt5.fcitx5-qt
        ];
        waylandFrontend = mkDefault isWayland';
      };
    };
  };
}
