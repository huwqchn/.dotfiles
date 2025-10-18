{
  pkgs,
  lib,
  config,
  ...
}: let
  shellAliases = {"z" = "zellij";};
  cfg = config.my.zellij;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkBefore;
  inherit (lib.meta) getExe;
  shell = getExe (builtins.getAttr config.my.shell pkgs);

  # Keyboard layout mappings similar to tmux
  layouts = {
    qwerty = {
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      next = "n";
      prev = "p";
    };
    colemak = {
      left = "n";
      down = "e";
      up = "i";
      right = "o";
      next = "k";
      prev = "K";
    };
  };
  layout = layouts.${config.my.keyboardLayout or "qwerty"};
in {
  options.my.zellij = {
    enable = mkEnableOption "Zellij";
    autoStart = mkEnableOption "zellij auto start";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = !(cfg.autoStart && config.my.tmux.autoStart or false);
        message = "Cannot enable both tmux.autoStart and zellij.autoStart simultaneously";
      }
    ];
    programs = {
      fish = mkIf cfg.autoStart {
        interactiveShellInit = ''
          if not set -q ZELLIJ
             and test -z "$SSH_TTY"
             and test -z "$WSL_DISTRO_NAME"
             and test -z "$INSIDE_EMACS"
             and test -z "$EMACS"
             and test -z "$VIM"
             and test -z "$NVIM"
             and test -z "$INSIDE_PYCHARM"
             and test -z "$TMUX"
             and test "$TERM_PROGRAM" != "vscode"
            zellij attach -c
          end
        '';
      };
      zsh = let
        key =
          if builtins.hasAttr "initContent" config.programs.zsh
          then "initContent"
          else "initExtraFirst";
      in
        mkIf cfg.autoStart {
          "${key}" = mkBefore ''
            if [[ -z "$ZELLIJ" ]] \
              && [[ -z "$SSH_TTY" ]] \
              && [[ -z "$WSL_DISTRO_NAME" ]] \
              && [[ -z "$INSIDE_PYCHARM" ]] \
              && [[ -z "$EMACS" ]] \
              && [[ -z "$VIM" ]] \
              && [[ -z "$NVIM" ]] \
              && [[ -z "$INSIDE_EMACS" ]] \
              && [[ -z "$TMUX" ]] \
              && [[ "$TERM_PROGRAM" != "vscode" ]]
            then
              zellij attach -c
            fi
          '';
        };
      zellij = {
        enable = true;
        settings = {
          # Enable tmux mode for tmux-like behavior
          default_mode = "tmux";
          # Simplified UI - disable beginner mode helpers
          pane_frames = false;
          simplified_ui = true;
          # Session behavior
          default_shell = shell;
          copy_on_select = false;
          scrollback_editor = getExe config.programs.neovim.package;
          # Mouse support
          mouse_mode = true;
          # Copy behavior
          copy_command =
            if pkgs.stdenv.hostPlatform.isDarwin
            then "pbcopy"
            else if pkgs.stdenv.hostPlatform.isLinux
            then "wl-copy"
            else "xclip -selection clipboard";
          # Theme handled by theme modules
          # Keybindings based on keyboard layout
          keybinds = {
            # Tmux mode keybindings (mimicking tmux behavior)
            tmux = {
              # Unbind defaults that conflict
              "bind \"Ctrl t\"" = {
                SwitchToMode = "Normal";
              };
              # Pane navigation (Ctrl + hjkl/neio)
              "bind \"Ctrl ${layout.left}\"" = {
                MoveFocus = "Left";
              };
              "bind \"Ctrl ${layout.down}\"" = {
                MoveFocus = "Down";
              };
              "bind \"Ctrl ${layout.up}\"" = {
                MoveFocus = "Up";
              };
              "bind \"Ctrl ${layout.right}\"" = {
                MoveFocus = "Right";
              };
              # Pane splitting (prefix + hjkl/neio)
              "bind \"${layout.left}\"" = {
                NewPane = "Left";
                SwitchToMode = "Normal";
              };
              "bind \"${layout.down}\"" = {
                NewPane = "Down";
                SwitchToMode = "Normal";
              };
              "bind \"${layout.up}\"" = {
                NewPane = "Up";
                SwitchToMode = "Normal";
              };
              "bind \"${layout.right}\"" = {
                NewPane = "Right";
                SwitchToMode = "Normal";
              };
              # Tab management
              "bind \"c\"" = {
                NewTab = {
                  SwitchToMode = "Normal";
                };
              };
              "bind \"${layout.next}\"" = {
                GoToNextTab = {};
              };
              "bind \"${layout.prev}\"" = {
                GoToPreviousTab = {};
              };
              "bind \"Tab\"" = {
                ToggleTab = {};
              };
              # Pane management
              "bind \"x\"" = {
                CloseFocus = {};
                SwitchToMode = "Normal";
              };
              "bind \"q\"" = {
                CloseFocus = {};
                SwitchToMode = "Normal";
              };
              "bind \"z\"" = {
                ToggleFocusFullscreen = {};
                SwitchToMode = "Normal";
              };
              # Mode switches
              "bind \"Space\"" = {
                SwitchToMode = "Scroll";
              };
              "bind \"[\"" = {
                SwitchToMode = "Scroll";
              };
              "bind \"s\"" = {
                SwitchToMode = "Session";
              };
              "bind \"r\"" = {
                SwitchToMode = "Resize";
              };
              "bind \"m\"" = {
                SwitchToMode = "Move";
              };
              "bind \",\"" = {
                SwitchToMode = "RenameTab";
                TabNameInput = 0;
              };
              "bind \"d\"" = {
                Detach = {};
              };
            };
            # Scroll mode (copy mode) with vim-like keybindings
            scroll = {
              "bind \"${layout.down}\" \"${layout.up}\" \"${layout.left}\" \"${layout.right}\"" = {};
              "bind \"Ctrl c\"" = {
                ScrollToBottom = {};
                SwitchToMode = "Normal";
              };
              "bind \"${layout.down}\"" = {
                ScrollDown = {};
              };
              "bind \"${layout.up}\"" = {
                ScrollUp = {};
              };
              "bind \"Ctrl f\"" = {
                PageScrollDown = {};
              };
              "bind \"Ctrl b\"" = {
                PageScrollUp = {};
              };
              "bind \"d\"" = {
                HalfPageScrollDown = {};
              };
              "bind \"u\"" = {
                HalfPageScrollUp = {};
              };
              "bind \"v\"" = {
                SwitchToMode = "EnterSearch";
                SearchInput = 0;
              };
              "bind \"/\"" = {
                SwitchToMode = "EnterSearch";
                SearchInput = 0;
              };
              "bind \"${layout.next}\"" = {
                Search = "down";
              };
              "bind \"${layout.prev}\"" = {
                Search = "up";
              };
            };
            # Resize mode
            resize = {
              "bind \"${layout.left}\"" = {
                Resize = "Increase Left";
              };
              "bind \"${layout.down}\"" = {
                Resize = "Increase Down";
              };
              "bind \"${layout.up}\"" = {
                Resize = "Increase Up";
              };
              "bind \"${layout.right}\"" = {
                Resize = "Increase Right";
              };
            };
            # Shared bindings across modes
            shared_except_normal = {
              "bind \"Esc\"" = {
                SwitchToMode = "Normal";
              };
            };
            shared_except_tmux = {
              "bind \"Ctrl t\"" = {
                SwitchToMode = "Tmux";
              };
            };
          };
        };
      };
    };

    home = {
      inherit shellAliases;
      persistence."/persist${config.home.homeDirectory}".directories = mkIf (config.home ? persistence) [
        ".local/share/zellij"
      ];
    };
  };
}
