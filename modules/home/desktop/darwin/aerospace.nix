{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.environment == "aerospace") {
    programs.aerospace = {
      enable = true;
      userSettings = {
        # You can use it to add commands that run after login to macOS user session.
        # 'start-at-login' needs to be 'true' for 'after-login-command' to work
        # Available commands: https://nikitabobko.github.io/AeroSpace/commands
        after-login-command = [];

        # You can use it to add commands that run after AeroSpace startup.
        # 'after-startup-command' is run after 'after-login-command'
        # Available commands : https://nikitabobko.github.io/AeroSpace/commands
        after-startup-command = [];

        # Start Aerospace at login
        start-at-login = true;

        # Normalizations. See: https://nikitabobko.github.io/AeroSpace/guide#normalization
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;

        # See: https://nikitabobko.github.io/AeroSpace/guide#layouts
        # The 'accordion-padding' specifies the size of accordion padding
        # You can set 0 to disable the padding feature
        accordion-padding = 30;

        # Possible values: tiles|accordion
        default-root-container-layout = "tiles";

        # Possible values: horizontal|vertical|auto
        # 'auto' means: wide monitor (anything wider than high) gets horizontal orientation,
        #               tall monitor (anything higher than wide) gets vertical orientation
        default-root-container-orientation = "auto";

        # Possible values: (qwerty|dvorak)
        # See https://nikitabobko.github.io/AeroSpace/guide#key-mapping
        key-mapping.preset = "qwerty";

        # Mouse follows focus when focused monitor changes
        # Drop it from your config, if you don't like this behavior
        # See https://nikitabobko.github.io/AeroSpace/guide#on-focus-changed-callbacks
        # See https://nikitabobko.github.io/AeroSpace/commands#move-mouse
        # Fallback value (if you omit the key): on-focused-monitor-changed = []
        on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];

        # Gaps configuration
        gaps = {
          inner = {
            horizontal = 10;
            vertical = 10;
          };
          outer = {
            left = 5;
            bottom = 5;
            top = 5;
            right = 5;
          };
        };

        exec = {
          inherit-env-vars = true;
          env-vars = {
            # You can add environment variables here
            # Example:
            # "MY_VAR" = "my_value";
            PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:$\{PATH\}";
          };
        };

        mode = {
          main = {
            binding = {
              # See: https://nikitabobko.github.io/AeroSpace/commands#layout
              "alt-slash" = "layout tiles horizontal vertical";
              "alt-backslash" = "layout accordion horizontal vertical";

              # See: https://nikitabobko.github.io/AeroSpace/commands#focus
              "alt-n" = "focus left";
              "alt-e" = "focus down";
              "alt-i" = "focus up";
              "alt-o" = "focus right";

              # See: https://nikitabobko.github.io/AeroSpace/commands#move
              "alt-shift-n" = "move left";
              "alt-shift-e" = "move down";
              "alt-shift-i" = "move up";
              "alt-shift-o" = "move right";

              # See: https://nikitabobko.github.io/AeroSpace/commands#resize
              "alt-shift-minus" = "resize smart -50";
              "alt-shift-equal" = "resize smart +50";

              # fullscreen
              "alt-f" = "fullscreen";

              # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
              "alt-1" = "workspace 1";
              "alt-2" = "workspace 2";
              "alt-3" = "workspace 3";
              "alt-4" = "workspace 4";
              "alt-5" = "workspace 5";
              "alt-6" = "workspace 6";
              "alt-7" = "workspace 7";
              "alt-8" = "workspace 8";
              "alt-9" = "workspace 9";
              "alt-0" = "workspace 0";

              # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
              "alt-shift-1" = "move-node-to-workspace 1";
              "alt-shift-2" = "move-node-to-workspace 2";
              "alt-shift-3" = "move-node-to-workspace 3";
              "alt-shift-4" = "move-node-to-workspace 4";
              "alt-shift-5" = "move-node-to-workspace 5";
              "alt-shift-6" = "move-node-to-workspace 6";
              "alt-shift-7" = "move-node-to-workspace 7";
              "alt-shift-8" = "move-node-to-workspace 8";
              "alt-shift-9" = "move-node-to-workspace 9";
              "alt-shift-0" = "move-node-to-workspace 0";

              # Custom shortcuts
              "alt-enter" = "exec-and-forget open -n /applications/ghostty.app";

              # cmd-b = 'exec-and-forget open -n /Applications/Arc.app'
              "alt-b" = "exec-and-forget open -a \"zen browser\"";

              # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
              "alt-tab" = "workspace-back-and-forth";
              # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
              "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";

              "alt-leftSquareBracket" = "workspace prev";
              "alt-rightSquareBracket" = "workspace next";
              "alt-shift-leftSquareBracket" = "move-node-to-workspace prev";
              "alt-shift-rightSquareBracket" = "move-node-to-workspace next";

              "alt-comma" = "focus-monitor left";
              "alt-period" = "focus-monitor right";

              "alt-shift-comma" = "move-node-to-monitor left";
              "alt-shift-period" = "move-node-to-monitor right";
              # See: https://nikitabobko.github.io/AeroSpace/commands#mode
              "alt-shift-semicolon" = "mode service";

              "alt-shift-r" = "reload-config";

              "alt-r" = "mode resize";
            };
          };
          resize = {
            binding = {
              "n" = "resize width -50";
              "e" = "resize height +50";
              "i" = "resize height -50";
              "o" = "resize width +50";
              "enter" = "mode main";
              "esc" = "mode main";
            };
          };
          service = {
            binding = {
              "esc" = ["reload-config" "mode main"];
              "r" = ["flatten-workspace-tree" "mode main"]; # reset layout
              "f" = [
                "layout floating tiling"
                "mode main"
              ]; # Toggle between floating and tiling layout
              "backspace" = ["close-all-windows-but-current" "mode main"];
              "alt-shift-n" = ["join-with left" "mode main"];
              "alt-shift-e" = ["join-with down" "mode main"];
              "alt-shift-i" = ["join-with up" "mode main"];
              "alt-shift-o" = ["join-with right" "mode main"];
            };
          };
        };
        on-window-detected = [
          {
            "if" = {
              app-id = "org.mozilla.com.zen.browser";
              window-title-regex-substring = "picture-in-picture";
            };
            run = "move-node-to-workspace 1";
          }
          {
            "if" = {
              app-id = "com.mitchellh.ghostty";
            };
            run = "move-node-to-workspace 1";
          }
          {
            "if" = {
              app-id = "company.thebrowser.Browser";
            };
            run = "move-node-to-workspace 1";
          }
          {
            "if" = {
              app-id = "com.microsoft.VSCode";
            };
            run = "move-node-to-workspace 1";
          }
          {
            "if" = {
              app-id = "com.tencent.xinWeChat";
            };
            run = "move-node-to-workspace 2";
          }
          {
            "if" = {
              app-id = "com.tencent.qq";
            };
            run = "move-node-to-workspace 2";
          }
          {
            "if" = {
              app-id = "com.spotify.client";
            };
            run = "move-node-to-workspace 4";
          }
          {
            "if" = {
              app-id = "com.hnc.Discord";
            };
            run = "move-node-to-workspace 4";
          }
          {
            "if" = {
              app-id = "ru.keepcoder.Telegram";
            };
            run = "move-node-to-workspace 4";
          }
        ];

        # Monitor assignments
        workspace-to-monitor-force-assignment = {
          "1" = "main";
          "2" = ["secondary" "main"];
          "3" = "main";
          "4" = ["secondary" "main"];
          "5" = "main";
          "6" = ["secondary" "main"];
          "7" = "main";
          "8" = ["secondary" "main"];
          "9" = "main";
          "0" = ["secondary" "main"];
        };
      };
    };
  };
}
