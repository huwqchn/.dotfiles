{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  cfg = config.my.desktop.apps.alacritty;
in {
  options.my.desktop.apps.alacritty = {
    enable =
      mkEnableOption "alacritty"
      // {
        default = config.my.terminal == "alacritty";
      };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      settings = {
        window = {
          padding = {
            x = 5;
            y = 5;
          };
          decorations =
            if isLinux
            then "none"
            else "buttonless";
          opacity = 0.95;
          title = "Alacritty";
          dynamic_title = true;
        };
        scrolling = {
          history = 10000;
          multiplier = 3;
        };
        font = {
          normal = {
            family = "JetBrains Mono Nerd Font";
            style = "Medium";
          };
          bold = {
            family = "JetBrains Mono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrains Mono Nerd Font";
            style = "MediumItalic";
          };
          bold_italic = {
            family = "JetBrains Mono Nerd Font";
            style = "BoldItalic";
          };

          # NOTE: font-size is managed by stylix
          # size = 13;
        };
        keyboard = {
          bindings = [
            {
              key = "Equals";
              mods = "Control";
              action = "IncreaseFontSize";
            }
            {
              key = "Plus";
              mods = "Control";
              action = "IncreaseFontSize";
            }
            {
              key = "Q";
              mods = "Command";
              action = "Quit";
            }
            {
              key = "W";
              mods = "Command";
              action = "Quit";
            }
            {
              key = "N";
              mods = "Command";
              action = "CreateNewWindow";
            }
            # distinguish between Tab and C-i
            {
              key = "H";
              mods = "Control";
              chars = "x1b[104;5u";
            }
            {
              key = "I";
              mods = "Control";
              chars = "x1b[105;5u";
            }
            {
              key = "M";
              mods = "Control";
              chars = "x1b[109;5u";
            }
            # remap Alt key
            {
              key = "A";
              mods = "Alt";
              chars = "x1ba";
            }
            {
              key = "B";
              mods = "Alt";
              chars = "x1bb";
            }
            {
              key = "C";
              mods = "Alt";
              chars = "x1bc";
            }
            {
              key = "D";
              mods = "Alt";
              chars = "x1bd";
            }
            {
              key = "E";
              mods = "Alt";
              chars = "x1be";
            }
            {
              key = "F";
              mods = "Alt";
              chars = "x1bf";
            }
            {
              key = "G";
              mods = "Alt";
              chars = "x1bg";
            }
            {
              key = "H";
              mods = "Alt";
              chars = "x1bh";
            }
            {
              key = "I";
              mods = "Alt";
              chars = "x1bi";
            }
            {
              key = "J";
              mods = "Alt";
              chars = "x1bj";
            }
            {
              key = "K";
              mods = "Alt";
              chars = "x1bk";
            }
            {
              key = "L";
              mods = "Alt";
              chars = "x1bl";
            }
            {
              key = "M";
              mods = "Alt";
              chars = "x1bm";
            }
            {
              key = "N";
              mods = "Alt";
              chars = "x1bn";
            }
            {
              key = "O";
              mods = "Alt";
              chars = "x1bo";
            }
            {
              key = "P";
              mods = "Alt";
              chars = "x1bp";
            }
            {
              key = "Q";
              mods = "Alt";
              chars = "x1bq";
            }
            {
              key = "R";
              mods = "Alt";
              chars = "x1br";
            }
            {
              key = "S";
              mods = "Alt";
              chars = "x1bs";
            }
            {
              key = "T";
              mods = "Alt";
              chars = "x1bt";
            }
            {
              key = "U";
              mods = "Alt";
              chars = "x1bu";
            }
            {
              key = "V";
              mods = "Alt";
              chars = "x1bv";
            }
            {
              key = "W";
              mods = "Alt";
              chars = "x1bw";
            }
            {
              key = "X";
              mods = "Alt";
              chars = "x1bx";
            }
            {
              key = "Y";
              mods = "Alt";
              chars = "x1by";
            }
            {
              key = "Z";
              mods = "Alt";
              chars = "x1bz";
            }
            {
              key = "A";
              mods = "Alt|Shift";
              chars = "x1bA";
            }
            {
              key = "W";
              mods = "Alt|Shift";
              chars = "x1bW";
            }
            {
              key = "X";
              mods = "Alt|Shift";
              chars = "x1bX";
            }
            {
              key = "Y";
              mods = "Alt|Shift";
              chars = "x1bY";
            }
            {
              key = "Z";
              mods = "Alt|Shift";
              chars = "x1bZ";
            }
            {
              key = "Key1";
              mods = "Alt";
              chars = "x1b1";
            }
            {
              key = "Key2";
              mods = "Alt";
              chars = "x1b2";
            }
            {
              key = "Key3";
              mods = "Alt";
              chars = "x1b3";
            }
            {
              key = "Key4";
              mods = "Alt";
              chars = "x1b4";
            }
            {
              key = "Key5";
              mods = "Alt";
              chars = "x1b5";
            }
            {
              key = "Key6";
              mods = "Alt";
              chars = "x1b6";
            }
            {
              key = "Key7";
              mods = "Alt";
              chars = "x1b7";
            }
            {
              key = "Key8";
              mods = "Alt";
              chars = "x1b8";
            }
            {
              key = "Key9";
              mods = "Alt";
              chars = "x1b9";
            }
            {
              key = "Key0";
              mods = "Alt";
              chars = "x1b0";
            }
            {
              key = "key1";
              mods = "alt|shift";
              chars = "x1b!";
            }
            {
              key = "key2";
              mods = "alt|shift";
              chars = "x1b@";
            }
            {
              key = "key3";
              mods = "alt|shift";
              chars = "x1b#";
            }
            {
              key = "key4";
              mods = "alt|shift";
              chars = "x1b$";
            }
            {
              key = "key5";
              mods = "alt|shift";
              chars = "x1b%";
            }
            {
              key = "key6";
              mods = "alt|shift";
              chars = "x1b^";
            }
            {
              key = "key7";
              mods = "alt|shift";
              chars = "x1b&";
            }
            {
              key = "key8";
              mods = "alt|shift";
              chars = "x1b*";
            }
            {
              key = "key9";
              mods = "alt|shift";
              chars = "x1b(";
            }
            {
              key = "key0";
              mods = "alt|shift";
              chars = "x1b)";
            }
            #- { key = space;     mods = control;   chars = "\x00"    ;    } # Ctrl + Space
            {
              key = "grave";
              mods = "alt";
              chars = "x1b`";
            } # Alt + `
            {
              key = "grave";
              mods = "alt|shift";
              chars = "x1b~";
            } # Alt + ~
            {
              key = "period";
              mods = "alt";
              chars = "x1b.";
            } # Alt + .
            {
              key = "period";
              mods = "alt|shift";
              chars = "x1b>";
            } # Alt + >
            {
              key = "comma";
              mods = "alt|shift";
              chars = "x1b<";
            } # Alt + <
            {
              key = "minus";
              mods = "alt|shift";
              chars = "x1b_";
            } # Alt + _
            {
              key = "backslash";
              mods = "alt";
              chars = "x1b\\";
            } # Alt + \
            {
              key = "return";
              mods = "alt";
              chars = "x1bx0d";
            } # Alt + Return - { key = Backslash; mods = Alt|Shift; chars = "\x1b|"                       } # Alt +
            {
              key = "back";
              mods = "alt";
              chars = "x1bx7f";
            } # Alt + Back
          ];
        };
      };
    };
  };
}
