{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.my) withUWSM;
  cfg = config.my.desktop.fcitx5;
  fcitx5' = withUWSM pkgs "fcitx5";
in {
  options.my.desktop.fcitx5 = {
    enable = mkEnableOption "Enable fcitx5 input method";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        settings = {
          inputMethod = {
            GroupOrder."0" = "Default";
            "Group/0" = {
              # Group name
              Name = "Default";
              # Layout
              "Default Layout" = "us";
              # Default Input Method
              "DefaultIM" = "rime";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "rime";
          };
          globalOptions = {
            Behavior = {
              # Active By Default
              ActiveByDefault = false;
              # Reset state on Focus In
              resetStateWhenFocusIn = false;
              # Share Input State
              ShareInputState = false;
              # Show preedit in application
              PreeditEnabledByDefault = true;
              # Show Input Method Information when switch input method
              ShowInputMethodInformation = true;
              # Show Input Method Information when changing focus
              showInputMethodInformationWhenFocusIn = false;
              # Show compact input method information
              CompactInputMethodInformation = true;
              # Show first input method information
              ShowFirstInputMethodInformation = true;
              # Default page size
              DefaultPageSize = 5;
              # Override Xkb Option
              OverrideXkbOption = false;
              # Custom Xkb Option
              CustomXkbOption = "";
              # Force Enabled Addons
              EnabledAddons = "";
              # Force Disabled Addons
              DisabledAddons = "";
              # Preload input method to be used by default
              PreloadInputMethod = true;
              # Allow input method in the password field
              AllowInputMethodForPassword = false;
              # Show preedit text when typing password
              ShowPreeditForPassword = false;
              # Interval of saving user data in minutes
              AutoSavePeriod = 30;
            };
            Hotkey = {
              # Enumerate when press trigger key repeatedly
              EnumerateWithTriggerKeys = true;
              # Skip first input method while enumerating
              EnumerateSkipFirst = false;
            };
            "Hotkey/TriggerKeys" = {
              "0" = "Control+space";
            };

            "Hotkey/AltTriggerKeys" = {
              "0" = "Shift_L";
            };

            "Hotkey/EnumerateForwardKeys" = {
              "0" = "Control+Shift_L";
            };

            "Hotkey/EnumerateBackwardKeys" = {
              "0" = "Control+Shift_R";
            };

            "Hotkey/EnumerateGroupForwardKeys" = {
              "0" = "Super+space";
            };

            "Hotkey/EnumerateGroupBackwardKeys" = {
              "0" = "Shift+Super+space";
            };

            "Hotkey/ActivateKeys" = {
              "0" = "Hangul_Hanja";
            };

            "Hotkey/DeactivateKeys" = {
              "0" = "Hangul_Romaja";
            };

            "Hotkey/PrevPage" = {"0" = "Up";};
            "Hotkey/NextPage" = {"0" = "Down";};

            "Hotkey/PrevCandidate" = {"0" = "Shift+Tab";};
            "Hotkey/NextCandidate" = {"0" = "Tab";};

            "Hotkey/TogglePreedit" = {"0" = "Control+Alt+P";};
          };
          addons = {
            rime = {
              # Show preedit within application
              PreeditInApplication = true;
              # Fix embedded preedit cursor at the beginning of the preedit
              PreeditCursorPositionAtBeginning = true;
              # Commit current text when deactivating
              "Commit when deactivate" = true;
            };
          };
        };
      };
    };
    wayland.windowManager.hyprland.settings.exec-once = [
      fcitx5'
    ];
  };
}
