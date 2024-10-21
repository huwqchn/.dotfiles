{
  pkgs,
  ...
}: let
  shellAliases = {
    "t" = "tmux";
  };
in {
  home.shellAliases = shellAliases;
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      # theme
      catppuccin

      sensible
      resurrect
      continuum
      jump
      yank
      copycat
      open
      tmux-fzf
      extrakto
      session-wizard
      mode-indicator
    ];
    extraConfig = ''
      # tmp options
      set-option -g @tpm-install "M-i";
      set-option -g @tpm-update "M-u";
      set-option -g @tpm-clean "M-l";

      # theme options
      set -g @catppuccin_pill_theme_enabled on
      set -g @catppuccin_window_tabs_enabled on
      set -g @catppuccin_date_time "%H:%M"

      # jump options
      set -g @jump-key ','

      # resurrect/continuum options
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-strategy-nvim 'session'
      set -g @continuum-boot 'on'
      set -g @continuum-restore 'on'

      # fzf options
      set -g @fzf-goto-session 's'
      set -g @fzf-goto-win-width 70
      set -g @fzf-goto-win-height 20

      # tmux-window-name options
      set -g @tmux_window_name_shells "['fish','zsh', 'bash', 'sh']"
      set -g @tmux_window_dir_programs "['nvim', 'vim', 'vi', 'git']"
      set -g @tmux_window_name_ignored_programs "['sqlite3']" # Default is []
      set -g @tmux_window_max_name_len "20"
      set -g @tmux_window_name_use_tilde "False"

      # tmux-copycat options
      set -g @copycat_next 'k'
      set -g @copycat_next 'K'
      set -g @copycat_ip_search 'M-p'

      # tmux open options
      set -g @open 'h'
      set -g @open-editor 'C-h'
      set -g @open-S 'https://www.google.com/search?q='

      # tmux native options
      setw -g xterm-keys on
      set -s escape-time 0
      set -sg repeat-time 300
      set -s focus-events on

      # Fix colors and enable true color support and italics
      set -g default-terminal "screen-256color"
      if 'infocmp -x tmux-256color > /dev/null 2>&1' 'set -g default-terminal "tmux-256color"'

      set -s extended-keys on
      set -as terminal-features 'xterm*:extkeys'

      # support mouse
      set -g mouse on

      # server will exit with no active session
      set -sg exit-empty on

      # utf8 is on
      set -q -g status-utf8 on
      setw -q -g utf8 on

      #Start numbering at 1 for windows and panes
      set -g base-index 1
      setw -g pane-base-index 1

      # automatically rename windows based on the application within
      setw -g automatic-rename on

      # Renumber windows if others are closed
      set -g renumber-windows on

      # Use titles in tabs
      set -g set-titles on

      set -g display-panes-time 2000
      set -g display-time 2000

      set -g status-interval 1

      set -g visual-activity off
      setw -g monitor-activity off
      setw -g monitor-bell off

      # history limit
      set -g history-limit 10000

      # set status bar position
      set -g status-position top
      # keybindings
      # -- prefix
      unbind C-b

      # Allows us to use C-a a <command> to send commands to a TMUX session inside
      set -g prefix C-t

      # another TMUX session
      bind-key C-t send-prefix

      # create new session
      bind M-s new-session

      # kill a session, suggest not to be use this keybind
      bind M-q kill-session

      # Select previous session
      bind M-p switch-client -p

      # Select next session
      bind M-n switch-client -n

      # chose-tree
      bind M-t choose-tree -Zs

      # break pane
      bind j break-pane

      # kill a window
      bind q kill-window

      # switch to last window
      # bind Tab last-window

      # creat a new window
      bind t new-window -c "#{pane_current_path}"

      # bind -r means repeatable
      # bind -r indicator multiple commands to be entered without pressing the prefix-key again in the specified time milliseconds
      bind -r [ previous-window
      bind -r ] next-window

      # display panes numbers
      bind a display-panes

      bind -r Space next-layout

      # split
      bind i split-window -vb -c "#{pane_current_path}"
      bind e split-window -v -c "#{pane_current_path}"
      bind n split-window -hb -c "#{pane_current_path}"
      bind o split-window -h -c "#{pane_current_path}"

      # pane navigation
      bind > swap-pane -D
      bind < swap-pane -U


      # bind t choose-tree -Zw
      # bind C-o last-window
      bind S choose-tree 'move-pane -v -s "%%"'
      bind V choose-tree 'move-pane -h -s "%%"'

      # find session
      bind M-s command-prompt -p find-session 'switch-client -t %%'

      # session navigation
      bind BTab switch-client -l  # move to last session

      # clear both screen and history
      bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

      # Copy mode
      set -g status-keys emacs

      bind Enter copy-mode

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi n send-keys -X cursor-left
      bind -T copy-mode-vi o send-keys -X cursor-right
      bind -T copy-mode-vi i send-keys -X cursor-up
      bind -T copy-mode-vi e send-keys -X cursor-down
      bind -T copy-mode-vi j send-keys -X next-word-end
      # bind -T copy-mode-vi I send-keys -N 5 -X cursor-up
      # bind -T copy-mode-vi E send-keys -N 5 -X cursor-down
      bind -T copy-mode-vi N send-keys -X start-of-line
      bind -T copy-mode-vi O send-keys -X end-of-line
      bind -T copy-mode-vi Y send-keys -X copy-end-of-line
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi k send-keys -X search-again
      bind -T copy-mode-vi K send-keys -X search-reverse

      # copy to X11 clipboard
      if -b 'command -v xsel > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xsel -i -b"'
      if -b '! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'
      # copy to macOS clipboard
      if -b 'command -v pbcopy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | pbcopy"'
      if -b 'command -v reattach-to-user-namespace > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"'
      # copy to Windows clipboard
      if -b 'command -v clip.exe > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | clip.exe"'
      if -b '[ -c /dev/clipboard ]' 'bind y run -b "tmux save-buffer - > /dev/clipboard"'

      bind b list-buffers
      bind p paste-buffer
      bind P choose-buffer

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
      bind-key -n C-n if-shell "$is_vim" 'send-keys C-n'  'select-pane -L'
      bind-key -n C-e if-shell "$is_vim" 'send-keys C-e'  'select-pane -D'
      bind-key -n C-i if-shell "$is_vim" 'send-keys C-i'  'select-pane -U'
      bind-key -n C-o if-shell "$is_vim" 'send-keys C-o'  'select-pane -R'
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

      bind-key -T copy-mode-vi 'C-n' select-pane -L
      bind-key -T copy-mode-vi 'C-e' select-pane -D
      bind-key -T copy-mode-vi 'C-i' select-pane -U
      bind-key -T copy-mode-vi 'C-o' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
  };
}

