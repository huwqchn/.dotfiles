#TODO: add layouts
{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.zellij;
  inherit (lib) mkEnableOption mkIf mkBefore getExe;

  shell = getExe (builtins.getAttr config.my.shell pkgs);

  # Helper functions for cleaner keybind definitions
  # mkBind converts a key-action pair into a Zellij keybind string
  mkBind = key: action:
    if builtins.isString action
    then "bind \"${key}\" {${action};}"
    else "bind \"${key}\" {${lib.concatStringsSep ";" action};}";

  # mkUnbind creates an unbind directive for one or multiple keys
  mkUnbind = key:
    if builtins.isString key
    then "unbind \"${key}\""
    else lib.concatStringsSep " " (map (k: "unbind \"${k}\"") key);

  # mkBinds converts an attrset of keybinds into Zellij format
  mkBinds = binds:
    lib.attrsets.mapAttrs' (key: action:
      lib.attrsets.nameValuePair (mkBind key action) {})
    binds;

  # mkMode creates a mode with support for clear-defaults and unbind
  # Usage:
  #   mkMode "normal" {
  #     clear-defaults = true;  # Optional: clear all default bindings
  #     unbind = "Ctrl q";      # Optional: unbind specific key(s)
  #     "Ctrl t" = "SwitchToMode \"Tmux\"";
  #   }
  mkMode = mode: bindings: let
    clearDefaults = bindings.clear-defaults or false;
    unbindKeys = bindings.unbind or null;
    actualBindings = removeAttrs bindings ["clear-defaults" "unbind"];
    modeName =
      if clearDefaults
      then "${mode} clear-defaults=true"
      else mode;
    modeBinds = mkBinds actualBindings;
    unbindAttrs =
      if unbindKeys != null
      then lib.attrsets.genAttrs [mkUnbind unbindKeys] (_: {})
      else {};
  in
    lib.attrsets.nameValuePair modeName (modeBinds // unbindAttrs);

  # mkKeybinds converts an attrset of modes to Zellij keybinds format
  # Usage:
  #   mkKeybinds {
  #     normal = { ... };
  #     tmux = { ... };
  #     scroll = { ... };
  #   }
  mkKeybinds = modes:
    builtins.listToAttrs (lib.attrsets.mapAttrsToList mkMode modes);

  # Common action builders
  SwitchToMode = mode: "SwitchToMode \"${mode}\"";
  GoToTab = tab: "GoToTab ${toString tab}";

  # Keyboard layout mappings
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
  layout = layouts.${config.my.keyboard.layout or "qwerty"};

  # Auto-start condition for zsh
  autoStartCheck = ''
    [[ -z "$ZELLIJ$SSH_TTY$WSL_DISTRO_NAME$INSIDE_PYCHARM$EMACS$VIM$NVIM$INSIDE_EMACS$TMUX" ]] \
      && [[ "$TERM_PROGRAM" != "vscode" ]]
  '';
in {
  options.my.zellij = {
    enable =
      mkEnableOption "Zellij"
      // {
        default = config.my.mux == "zellij";
      };
    autoStart =
      mkEnableOption "zellij auto start"
      // {
        default = config.my.mux == "zellij";
      };
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
             and test -z "$SSH_TTY$WSL_DISTRO_NAME$INSIDE_EMACS$EMACS$VIM$NVIM$INSIDE_PYCHARM$TMUX"
             and test "$TERM_PROGRAM" != "vscode"
            zellij attach -c
          end
        '';
      };

      zsh = mkIf cfg.autoStart {
        initContent = mkBefore ''
          if ${autoStartCheck}; then
            zellij attach -c
          fi
        '';
      };

      zellij = {
        enable = true;
        settings = {
          default_mode = "locked";
          default_shell = shell;
          pane_frames = false;
          simplified_ui = true;
          copy_on_select = false;
          mouse_mode = true;
          scrollback_editor = getExe config.programs.neovim.package;
          copy_command =
            if pkgs.stdenv.hostPlatform.isDarwin
            then "pbcopy"
            else if pkgs.stdenv.hostPlatform.isLinux
            then "wl-copy"
            else "xclip -selection clipboard";

          keybinds = mkKeybinds {
            tmux = {
              "Ctrl t" = SwitchToMode "Normal";
              # Pane navigation with Ctrl
              "Ctrl ${layout.left}" = "MoveFocus \"Left\"";
              "Ctrl ${layout.down}" = "MoveFocus \"Down\"";
              "Ctrl ${layout.up}" = "MoveFocus \"Up\"";
              "Ctrl ${layout.right}" = "MoveFocus \"Right\"";
              # Pane splitting
              "${layout.left}" = ["NewPane \"Left\"" (SwitchToMode "Normal")];
              "${layout.down}" = ["NewPane \"Down\"" (SwitchToMode "Normal")];
              "${layout.up}" = ["NewPane \"Up\"" (SwitchToMode "Normal")];
              "${layout.right}" = ["NewPane \"Right\"" (SwitchToMode "Normal")];
              # Tab management
              "c" = ["NewTab" (SwitchToMode "Normal")];
              "${layout.next}" = "GoToNextTab";
              "${layout.prev}" = "GoToPreviousTab";
              "Tab" = "ToggleTab";
              # Quick tab access
              "1" = [(GoToTab 1) (SwitchToMode "Normal")];
              "2" = [(GoToTab 2) (SwitchToMode "Normal")];
              "3" = [(GoToTab 3) (SwitchToMode "Normal")];
              "4" = [(GoToTab 4) (SwitchToMode "Normal")];
              "5" = [(GoToTab 5) (SwitchToMode "Normal")];
              "6" = [(GoToTab 6) (SwitchToMode "Normal")];
              "7" = [(GoToTab 7) (SwitchToMode "Normal")];
              "8" = [(GoToTab 8) (SwitchToMode "Normal")];
              "9" = [(GoToTab 9) (SwitchToMode "Normal")];
              # Pane management
              "x" = ["CloseFocus" (SwitchToMode "Normal")];
              "z" = ["ToggleFocusFullscreen" (SwitchToMode "Normal")];
              # Mode switches
              "Space" = SwitchToMode "Scroll";
              "[" = SwitchToMode "Scroll";
              "s" = SwitchToMode "Session";
              "r" = SwitchToMode "Resize";
              "m" = SwitchToMode "Move";
              "," = ["SwitchToMode \"RenameTab\"" "TabNameInput 0"];
              "d" = "Detach";
            };
            scroll = {
              "${layout.down}" = "ScrollDown";
              "${layout.up}" = "ScrollUp";
              "g" = "ScrollToTop";
              "G" = "ScrollToBottom";
              "d" = "HalfPageScrollDown";
              "u" = "HalfPageScrollUp";
              "Ctrl f" = "PageScrollDown";
              "Ctrl b" = "PageScrollUp";
              "/" = "Search \"down\"";
              "?" = "Search \"up\"";
              "${layout.next}" = "Search \"down\"";
              "${layout.prev}" = "Search \"up\"";
            };
            resize = {
              "${layout.left}" = "Resize \"Increase Left\"";
              "${layout.down}" = "Resize \"Increase Down\"";
              "${layout.up}" = "Resize \"Increase Up\"";
              "${layout.right}" = "Resize \"Increase Right\"";
            };
            shared_except_normal = {
              "Esc" = SwitchToMode "Normal";
            };
            shared_except_tmux = {
              "Ctrl t" = SwitchToMode "Tmux";
            };
          };
        };
      };
    };

    home = {
      shellAliases.z = "zellij";
      persistence."/persist${config.home.homeDirectory}".directories = mkIf (config.home ? persistence) [
        ".local/share/zellij"
      ];
    };
  };
}
