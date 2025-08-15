{
  pkgs,
  lib,
  config,
  ...
}: let
  shellAliases = {"t" = "tmux";};
  cfg = config.my.tmux;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkBefore;
  inherit (lib.strings) optionalString;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  inherit (lib.meta) getExe getExe';
  shell = getExe (builtins.getAttr config.my.shell pkgs);
  layouts = {
    qwerty = {
      break-pane = "J";
      display-message = "i";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      Left = "H";
      Down = "J";
      Up = "K";
      Right = "L";
      next-word = "e";
      next = "n";
      prev = "N";
      other-end = "o";
    };
    colemak = {
      break-pane = "j";
      display-message = "I";
      left = "n";
      down = "e";
      up = "i";
      right = "o";
      Left = "N";
      Down = "E";
      Up = "I";
      Right = "O";
      next-word = "j";
      next = "k";
      prev = "K";
      other-end = "l";
    };
  };
  layout = layouts.${config.my.keyboardLayout or "qwerty"};
in {
  options.my.tmux = {
    enable = mkEnableOption "tmux";
    autoStart =
      mkEnableOption "tmux auto start"
      // {
        default = true;
      };
  };

  config = mkIf cfg.enable {
    programs = {
      fish = mkIf cfg.autoStart {
        interactiveShellInit = ''
          if not set -q TMUX
             and test -z "$SSH_TTY"
             and test -z "$WSL_DISTRO_NAME"
             and test -z "$INSIDE_EMACS"
             and test -z "$EMACS"
             and test -z "$VIM"
             and test -z "$NVIM"
             and test -z "$INSIDE_PYCHARM"
             and test -z "$ZELLIJ_SESSION_NAME"
             and test "$TERM_PROGRAM" != "vscode"
            tmux attach-session; or tmux
          end
        '';
      };
      zsh = let
        # see: https://github.com/catppuccin/nix/pull/543/files
        key =
          if builtins.hasAttr "initContent" config.programs.zsh
          then "initContent"
          else "initExtraFirst";
      in
        mkIf cfg.autoStart {
          "${key}" = mkBefore ''
            if [[ -z "$TMUX" ]] \
              && [[ -z "$SSH_TTY" ]] \
              && [[ -z "$WSL_DISTRO_NAME" ]] \
              && [[ -z "$INSIDE_PYCHARM" ]] \
              && [[ -z "$EMACS" ]] \
              && [[ -z "$VIM" ]] \
              && [[ -z "$NVIM" ]] \
              && [[ -z "$INSIDE_EMACS" ]] \
              && [[ -z "$ZELLIJ_SESSION_NAME" ]] \
              && [[ "$TERM_PROGRAM" != "vscode" ]]
            then
              tmux attach-session || tmux;
            fi
          '';
        };
      tmux = {
        enable = true;
        baseIndex = 1;
        clock24 = true;
        mouse = true;
        prefix = "C-t";
        keyMode = "vi";
        escapeTime = 0;
        historyLimit = 50000;
        focusEvents = true;
        aggressiveResize = true;
        terminal = "screen-256color";
        inherit shell;
        plugins = with pkgs.tmuxPlugins; [
          # R -> reload tmux config
          # set-option -g status-keys emacs
          # set-option -g display-time 4000

          # sensible

          # theme
          # {
          #   plugin = catppuccin;
          #   extraConfig = ''
          #     set -g @catppuccin_pill_theme_enabled on
          #     set -g @catppuccin_window_tabs_enabled on
          #     set -g @catppuccin_date_time "%H:%M"
          #   '';
          # }
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-capture-pane-contents 'on'
              set -g @resurrect-strategy-nvim 'session'
            '';
          }
          {
            plugin = continuum;
            extraConfig = ''
              set -g @continuum-boot 'off'
              set -g @continuum-restore 'on'
            '';
          }
          {
            plugin = jump;
            extraConfig = "set -g @jump-key 'Enter'";
          }
          yank
          # {
          #   plugin = open;
          #   extraConfig = ''
          #     set -g @open 'x'
          #     set -g @open-editor 'X'
          #   '';
          # }
          {
            plugin = tmux-fzf;
            extraConfig = ''
              TMUX_FZF_LAUNCH_KEY="f"
              TMUX_FZF_ORDER="session|window|pane|command|keybinding|clipboard|process"
            '';
          }
        ];
        extraConfig = ''
          # -------------------
          # tmux native options
          # -------------------
          set-option -g status-keys emacs
          set-option -g display-time 4000

          # source tmux config file
          bind r source-file "~/.config/tmux/tmux.conf" \; display 'Sourced tmux.conf'

          # display panes numbers
          bind a display-panes

          # undercurl support
          set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
          # underscore colours - needs tmux-3.0
          set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

          # With this set to off
          # when you close the last window in a session, tmux will keep the session
          # alive, even though it has no windows open. You won't be detached from
          # tmux, and you'll remain in the session
          set -g detach-on-destroy off

          # https://github.com/3rd/image.nvim/?tab=readme-ov-file#tmux
          # This is needed by the image.nvim plugin
          set -gq allow-passthrough on
          # This is related to the `tmux_show_only_in_active_window = true,` config in
          # image.nvim
          set -g visual-activity off

          # Notifying if other windows has activities
          setw -g monitor-activity on
          setw -g monitor-bell on

          # Imagine if you have windows 1-5, and you close window 3, you are left with
          # 1,2,4,5, which is inconvenient for my navigation method seen below
          # renumbering solves that issue, so if you close 3 your left with 1-4
          set -g renumber-windows on

          setw -g xterm-keys on
          set -sg repeat-time 300

          # Fix colors and enable true color support and italics
          if 'infocmp -x tmux-256color > /dev/null 2>&1' 'set -g default-terminal "tmux-256color"'

          set -s extended-keys on
          set -as terminal-features 'xterm*:extkeys'

          # server will exit with no active session
          set -sg exit-empty on

          # utf8 is on
          set -q -g status-utf8 on
          setw -q -g utf8 on

          # Use titles in tabs
          set -g set-titles on

          # Border lines between panes are thicker
          # single -> single lines using ACS or UTF-8 characters
          # double -> double lines using UTF-8 characters
          # heavy  -> heavy lines using UTF-8 characters
          # simple -> simple ASCII characters
          # number -> the pane number
          set -g pane-border-lines single

          # Indicate active pane by colouring only half of the border in windows with
          # exactly two panes, by displaying arrow markers, by drawing both or neither.
          # [off | colour | arrows | both]
          set -g pane-border-indicators colour

          # set status bar position
          set -g status-position top

          # -------------------
          # keybindings
          # -------------------
          # Search sessions using an fzf menu
          # Found this gem down here:
          # https://github.com/majjoha/dotfiles/blob/cd6f966d359e16b3a7c149f96d4edb8a83e769db/.config/tmux/tmux.conf#L41
          bind M-s display-popup -E -w 75% -h 75% "\
            tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
            sed '/^$/d' |\
            fzf --reverse --header jump-to-session --preview 'tmux capture-pane -pt {}'  |\
            xargs tmux switch-client -t"


          # fzf menu to kill sessions
          # Credit: video below by Waylon Walker
          # https://www.youtube.com/watch?v=QWPyYx54JbE
          bind M-S display-popup -E "\
              tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
              fzf --reverse -m --header=kill-session |\
              xargs -I {} tmux kill-session -t {}"


          # kill a session, suggest not to be use this keybind
          bind M-q kill-session

          # break pane
          bind ${layout.break-pane} break-pane

          # kill a window
          bind q kill-window

          # creat a new window
          bind t new-window -c "#{pane_current_path}"

          # bind -r means repeatable
          # bind -r indicator multiple commands to be entered without pressing the prefix-key again in the specified time milliseconds
          bind -r [ previous-window
          bind -r ] next-window

          # display panes numbers
          bind p display-panes

          # display time
          bind c clock-mode

          # Select pane
          bind Tab select-pane -t:.+

          # display message
          bind ${layout.display-message} display-message

          # list buffers
          bind b list-buffers

          # Alternate session
          # Switch between the last 2 tmux sessions, similar to 'cd -' in the terminal
          # I use this in combination with the `choose-tree` to sort sessions by time
          # Otherwise, by default, sessions are sorted by name, and that makes no sense
          # -l stands for `last session`, see `man tmux`
          bind Tab switch-client -l

          # split
          unbind '"'
          unbind %
          bind ${layout.up} split-window -vb -c "#{pane_current_path}"
          bind ${layout.down} split-window -v -c "#{pane_current_path}"
          bind ${layout.left} split-window -hb -c "#{pane_current_path}"
          bind ${layout.right} split-window -h -c "#{pane_current_path}"

          # When pressing prefix+s to list sessions, I want them sorted by time
          # That way my latest used sessions show at the top of the list
          # -s starts with sessions collapsed (doesn't show windows)
          # -Z zooms the pane (don't understand what this does)
          # -O specifies the initial sort field: one of ‘index’, ‘name’, or ‘time’ (activity).
          # https://unix.stackexchange.com/questions/608268/how-can-i-force-tmux-to-sort-my-sessions-alphabetically
          # bind s choose-tree -Zs -O time
          # bind s choose-tree -Zs -O time -y
          bind s choose-tree -Zs -O time -F "#{session_windows}"
          # -y at the end is a feature I requested so that the session is closed without confirmation
          # https://github.com/tmux/tmux/issues/4152
          # bind s choose-tree -Zs -O time -F "#{session_windows}" -y
          # bind s choose-tree -Zs -O time -F "#{?session_attached,#[fg=$linkarzu_color02],#[fg=$linkarzu_color03]}#{session_name}#[default]" -y
          # bind s choose-tree -Zs -O time -F "#{?session_attached,#[fg=$linkarzu_color02],#[fg=$linkarzu_color03]}" -y

          # clear both screen and history
          # bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

          bind Space copy-mode
          bind -T copy-mode-vi v send-keys -X begin-selection
          bind -T copy-mode-vi ${layout.left} send-keys -X cursor-left
          bind -T copy-mode-vi ${layout.right} send-keys -X cursor-right
          bind -T copy-mode-vi ${layout.up} send-keys -X cursor-up
          bind -T copy-mode-vi ${layout.down} send-keys -X cursor-down
          bind -T copy-mode-vi ${layout.Down} send -X scroll-down
          bind -T copy-mode-vi ${layout.Up} send -X scroll-up
          bind -T copy-mode-vi ${layout.next-word} send-keys -X next-word-end
          bind -T copy-mode-vi ${layout.Left} send-keys -X start-of-line
          bind -T copy-mode-vi ${layout.Right} send-keys -X end-of-line

          # commented out because it's handly by tmux-yank
          # bind -T copy-mode-vi Y send-keys -X copy-end-of-line
          # bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          bind -T copy-mode-vi ${layout.next} send-keys -X search-again
          bind -T copy-mode-vi ${layout.prev} send-keys -X search-reverse
          bind -T copy-mode-vi ${layout.other-end} send-keys -X other-end

          # don't exit copy mode when dragging with mouse
          unbind -T copy-mode-vi MouseDragEnd1Pane

          # copy to X11 clipboard
          if -b 'command -v xsel > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xsel -i -b"'
          if -b '! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'
          # copy to macOS clipboard
          if -b 'command -v pbcopy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | pbcopy"'
          if -b 'command -v reattach-to-user-namespace > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"'
          # copy to Windows clipboard
          if -b 'command -v clip.exe > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | clip.exe"'
          if -b '[ -c /dev/clipboard ]' 'bind y run -b "tmux save-buffer - > /dev/clipboard"'

          # -- toggle_syn_input
          bind C-g if-shell '[[ $(tmux showw synchronize-panes | cut -d\  -f2) == "on" ]]' \
          'setw synchronize-panes off; set -g pane-border-style fg=magenta' \
          'setw synchronize-panes on; set -g pane-border-style fg=red'

          # -- toggle_status
          bind C-b if-shell '[[ $(tmux show -g status | cut -d\  -f2) == "on" ]]' \
          'set -g status off' \
          'set -g status on'

          # vim tmux navigation
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
          bind-key -n C-${layout.left} if-shell "$is_vim" 'send-keys C-${layout.left}'  'select-pane -L'
          bind-key -n C-${layout.down} if-shell "$is_vim" 'send-keys C-${layout.down}'  'select-pane -D'
          bind-key -n C-${layout.up} if-shell "$is_vim" 'send-keys C-${layout.up}'  'select-pane -U'
          bind-key -n C-${layout.right} if-shell "$is_vim" 'send-keys C-${layout.right}'  'select-pane -R'
          bind-key -n C-q if-shell "$is_vim" 'send-keys C-q'  'kill-pane'

          bind-key -n C-Left if-shell "$is_vim" 'send-keys C-Left' 'resize-pane -L 3'
          bind-key -n C-Down if-shell "$is_vim" 'send-keys C-Down' 'resize-pane -D 3'
          bind-key -n C-Up if-shell "$is_vim" 'send-keys C-Up' 'resize-pane -U 3'
          bind-key -n C-Right if-shell "$is_vim" 'send-keys C-Right' 'resize-pane -R 3'

          tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
          if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
          if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

          bind-key -T copy-mode-vi 'C-${layout.left}' select-pane -L
          bind-key -T copy-mode-vi 'C-${layout.down}' select-pane -D
          bind-key -T copy-mode-vi 'C-${layout.up}' select-pane -U
          bind-key -T copy-mode-vi 'C-${layout.right}' select-pane -R
          bind-key -T copy-mode-vi 'C-\' select-pane -l
          ${optionalString isDarwin ''
            set-option -g default-command "${getExe' pkgs.reattach-to-user-namespace "reattach-to-user-namespace"} -l ${shell}"
          ''}
        '';
      };
    };

    home = {
      inherit shellAliases;
      persistence."/persist${config.home.homeDirectory}".directories = [
        ".tmux"
      ];
    };
  };
}
