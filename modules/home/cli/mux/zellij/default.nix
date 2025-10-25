#TODO: add layouts
{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.zellij;
  autoStart = config.my.mux.autoStart && config.my.mux.default == "zellij";
  inherit (lib) mkEnableOption mkIf mkBefore getExe;

  shell = getExe (builtins.getAttr config.my.shell pkgs);

  # Auto-start condition for zsh
  autoStartCheck = ''
    [[ -z "$ZELLIJ$SSH_TTY$WSL_DISTRO_NAME$INSIDE_PYCHARM$EMACS$VIM$NVIM$INSIDE_EMACS$TMUX" ]] \
      && [[ "$TERM_PROGRAM" != "vscode" ]]
  '';
in {
  imports = lib.my.scanPaths ./.;

  options.my.zellij = {
    enable =
      mkEnableOption "Zellij"
      // {
        default = config.my.mux.default == "zellij";
      };
  };

  config = mkIf cfg.enable {
    programs = {
      fish = mkIf autoStart {
        interactiveShellInit = ''
          if not set -q ZELLIJ
             and test -z "$SSH_TTY$WSL_DISTRO_NAME$INSIDE_EMACS$EMACS$VIM$NVIM$INSIDE_PYCHARM$TMUX"
             and test "$TERM_PROGRAM" != "vscode"
            zellij attach -c
            _update_zellij_tab_name
          end
        '';
        functions."_update_zellij_tab_name" = {
          onEvent = "fish_prompt";
          onVariable = "PWD";
          body = ''
            set -l cwd (pwd)
            if git rev-parse --is-inside-worktree >/dev/null 2>&1
                # just show basename if inside a git worktree
                set cwd (basename "$cwd")
            else
                # otherwise, replace $HOME with ~ and truncate if needed
                set cwd (string replace "$HOME" "~" "$cwd")
                if test (string length "$cwd") -gt 30
                    set -l parts (string split / "$cwd")
                    set -l first (string join / $parts[1])
                    set -l last (string join / $parts[-1])
                    set cwd "$first/…/$last"
                end
            end
            set -l title "$cwd"
            command nohup zellij action rename-tab "$title" >/dev/null 2>&1
          '';
        };
      };

      zsh = mkIf autoStart {
        initContent = mkBefore ''
          if ${autoStartCheck}; then
            zellij attach -c
          fi
        '';
      };

      zellij = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        settings = {
          default_mode = "tmux";
          default_shell = shell;
          pane_frames = false;
          simplified_ui = true;
          copy_on_select = true;
          mouse_mode = true;
          scrollback_editor = getExe config.programs.neovim.package;
          show_startup_tips = false;
          # TODO: add option that handles darwin and X11/Wayland
          copy_command =
            if pkgs.stdenv.hostPlatform.isDarwin
            then "pbcopy"
            else if pkgs.stdenv.hostPlatform.isLinux
            then "wl-copy"
            else "xclip -selection clipboard";
          # serialized
          serialize_pane_viewport = true;
          session_serialization = true;

          # https://zellij.dev/tutorials/web-client/
          web_server = true;
          # Generated with `nix run nixpkgs#mkcert -install localhost 127.0.0.1`
          web_server_cert = builtins.toString /etc/nixos/localhost+1.pem;
          web_server_key = builtins.toString /etc/nixos/localhost+1-key.pem;
          enforce_https_over_localhost = true;
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
