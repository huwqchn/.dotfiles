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

  # mkMode creates a mode with support for clear-defaults, unbind, and special mode keywords
  # Usage:
  #   mkMode "normal" {
  #     clear-defaults = true;  # Optional: clear all default bindings
  #     unbind = "Ctrl q";      # Optional: unbind specific key(s)
  #     "Ctrl t" = "SwitchToMode \"Tmux\"";
  #   }
  #   mkMode "shared" { ... }  # Applies to all modes
  #   mkMode "shared_except" {
  #     modes = ["resize" "locked"];  # modes to exclude
  #     "Ctrl g" = "SwitchToMode \"locked\"";
  #   }
  #   mkMode "shared_among" {
  #     modes = ["resize" "locked"];  # modes to include
  #     "Ctrl g" = "SwitchToMode \"locked\"";
  #   }
  #   For multiple shared_except/shared_among with different mode lists, use descriptive names:
  #   mkMode "shared_except_normal" { ... }  # Will be parsed as shared_except
  #   mkMode "shared_among_resize_move" { ... }  # Will be parsed as shared_among
  mkMode = mode: bindings: let
    clearDefaults = bindings.clear-defaults or false;
    unbindKeys = bindings.unbind or null;
    modesList = bindings.modes or null;
    actualBindings = removeAttrs bindings ["clear-defaults" "unbind" "modes"];

    # Detect if mode name starts with special keywords
    isShared = mode == "shared";
    isSharedExcept = lib.hasPrefix "shared_except" mode;
    isSharedAmong = lib.hasPrefix "shared_among" mode;

    # Handle special mode keywords with mode list syntax
    modeName =
      if isShared
      then "shared"
      else if isSharedExcept && modesList != null
      then "shared_except \"${lib.concatStringsSep "\" \"" modesList}\""
      else if isSharedAmong && modesList != null
      then "shared_among \"${lib.concatStringsSep "\" \"" modesList}\""
      else if clearDefaults
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

      zellij = with config.my.keyboard.keys; {
        enable = true;
        settings = {
          default_mode = "locked";
          default_shell = shell;
          pane_frames = false;
          simplified_ui = true;
          copy_on_select = false;
          mouse_mode = true;
          scrollback_editor = getExe config.programs.neovim.package;
          show_startup_tips = false;
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
              "Ctrl ${h}" = "MoveFocus \"Left\"";
              "Ctrl ${j}" = "MoveFocus \"Down\"";
              "Ctrl ${k}" = "MoveFocus \"Up\"";
              "Ctrl ${l}" = "MoveFocus \"Right\"";
              # Pane splitting
              h = ["NewPane \"Left\"" (SwitchToMode "Normal")];
              j = ["NewPane \"Down\"" (SwitchToMode "Normal")];
              k = ["NewPane \"Up\"" (SwitchToMode "Normal")];
              l = ["NewPane \"Right\"" (SwitchToMode "Normal")];
              # Tab management
              "c" = ["NewTab" (SwitchToMode "Normal")];
              n = "GoToNextTab";
              N = "GoToPreviousTab";
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
              j = "ScrollDown";
              k = "ScrollUp";
              "g" = "ScrollToTop";
              "G" = "ScrollToBottom";
              "d" = "HalfPageScrollDown";
              "u" = "HalfPageScrollUp";
              "Ctrl f" = "PageScrollDown";
              "Ctrl b" = "PageScrollUp";
              "/" = "Search \"down\"";
              "?" = "Search \"up\"";
              n = "Search \"down\"";
              N = "Search \"up\"";
            };
            resize = {
              h = "Resize \"Increase Left\"";
              j = "Resize \"Increase Down\"";
              k = "Resize \"Increase Up\"";
              l = "Resize \"Increase Right\"";
            };
            # Using the new shared_except syntax - applies to all modes except specified ones
            shared_except = {
              modes = ["normal"];
              "Esc" = SwitchToMode "Normal";
            };
            shared_except_tmux = {
              modes = ["tmux"];
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
