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
          fcitx5-gtk
          fcitx5-configtool #if having issues with qt compatibility, run fcitx5-config-qt
          fcitx5-chinese-addons
          fcitx5-mozc
          fcitx5-pinyin-moegirl
          fcitx5-pinyin-zhwiki
          libsForQt5.fcitx5-qt
          (fcitx5-rime.override {
            rimeDataPkgs = [
              # /run/current-system/sw/share/rime-data/
              pkgs.rime-ice
            ];
          })
        ];
        waylandFrontend = mkDefault isWayland';
        settings = {
          inputMethod = {
            "GroupOrder" = {
              "0" = "default";
            };
            "Groups/0" = {
              "Name" = "default";
              "DefaultIM" = "rime";
              "Default Layout" = "us";
            };
            "Groups/0/Items/0" = {
              "Name" = "rime";
            };
            "Groups/0/Items/1" = {
              "Name" = "keyboard-us";
            };
          };
          globalOptions = {
            "Hotkey/TriggerKeys" = {
              "0" = "";
              # "0" = "Control+space";
            };
            "Hotkey/AltTriggerKeys" = {
              "0" = "";
            };
          };
          addons = {
            classicui.globalSection = {
              Font = "Noto Sans CJK SC 12";
              # MenuFont = "Sans Serif 12";
              # TrayFont = "Sans Serif 12";
            };
            clipboard = {
              globalSection = {
                "TriggerKey" = "";
              };
              # sections.TriggerKey = {
              #   "0" = "Control+Alt+semicolon";
              # };
            };
            notifications = {
              globalSection = {};
              sections.HiddenNotifications = {
                "0" = "fcitx-rime-deploy";
              };
            };
          }; # end of addons
        }; # end of fcitx5.settings
      };
    };
  };
}
