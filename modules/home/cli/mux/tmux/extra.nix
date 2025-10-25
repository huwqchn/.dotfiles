{
  lib,
  pkgs,
  config,
  ...
}: let
  # Helper functions for cleaner tmux configuration
  # mkBind: Create a bind command with optional flags
  # Usage:
  #   mkBind { key = "r"; action = "source-file ~/.config/tmux/tmux.conf"; }
  #   mkBind { key = "["; action = "previous-window"; repeat = true; }
  #   mkBind { key = "C-h"; table = "copy-mode-vi"; action = "select-pane -L"; }
  #   mkBind { key = "C-l"; action = "send-keys C-l"; noPrefix = true; }
  mkBind = {
    key,
    action,
    repeat ? false, # -r flag: allow repeating without prefix
    table ? null, # -T flag: specify key table (e.g., "copy-mode-vi")
    noPrefix ? false, # -n flag: bind without requiring prefix key
  }: let
    flags =
      lib.optionals repeat ["-r"]
      ++ lib.optionals (table != null) ["-T" table]
      ++ lib.optionals noPrefix ["-n"];
    flagStr =
      if flags == []
      then ""
      else "${lib.concatStringsSep " " flags} ";
  in "bind ${flagStr}${key} ${action}";

  # mkUnbind: Remove a key binding
  # Usage:
  #   mkUnbind "\""
  #   mkUnbind { key = "C-h"; table = "copy-mode-vi"; }
  mkUnbind = args:
    if builtins.isString args
    then "unbind ${args}"
    else let
      inherit (args) key;
      table = args.table or null;
      flags = lib.optionals (table != null) ["-T" table];
      flagStr =
        if flags == []
        then ""
        else "${lib.concatStringsSep " " flags} ";
    in "unbind ${flagStr}${key}";

  # mkSet: Set a tmux option with optional flags
  # Usage:
  #   mkSet { option = "status-keys"; value = "emacs"; }
  #   mkSet { option = "default-terminal"; value = "tmux-256color"; global = true; }
  #   mkSet { option = "terminal-overrides"; value = "..."; append = true; server = true; }
  #   mkSet { option = "monitor-activity"; value = "on"; window = true; }
  #   mkSet { option = "status-utf8"; value = "on"; global = true; quiet = true; }
  mkSet = {
    option,
    value,
    global ? false, # -g flag: set global option
    server ? false, # -s flag: set server option
    window ? false, # -w flag: set window option (same as setw)
    append ? false, # -a flag: append to existing value
    appendString ? false, # -as flag: append string to existing value
    quiet ? false, # -q flag: don't report error if option doesn't exist
  }: let
    command =
      if window
      then "setw"
      else "set";
    flags =
      lib.optionals global ["-g"]
      ++ lib.optionals server ["-s"]
      ++ lib.optionals quiet ["-q"]
      ++ (
        if appendString
        then ["-as"]
        else lib.optionals append ["-a"]
      );
    flagStr =
      if flags == []
      then ""
      else "${lib.concatStringsSep " " flags} ";
  in "${command} ${flagStr}${option} ${value}";
  # mkSetUnquoted: Same as mkSet but without quotes around value (for special cases)
  inherit (lib.strings) optionalString;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  inherit (lib.meta) getExe' getExe;
  shell = getExe (builtins.getAttr config.my.shell pkgs);
in {
  programs.tmux.extraConfig = with config.my.keyboard.keys; ''
    # Fix colors and enable true color support and italics
    if 'infocmp -x tmux-256color > /dev/null 2>&1' 'set -g default-terminal "tmux-256color"'
    # sets
    ${mkSet {
      option = "extended-keys";
      value = "on";
      server = true;
    }}
    ${mkSet {
      option = "terminal-features";
      value = "'xterm*:extkeys'";
      appendString = true;
    }}
    ${mkSet {
      option = "exit-empty";
      value = "on";
      server = true;
      global = true;
    }}
    # utf8 is on
    ${mkSet {
      option = "status-utf8";
      value = "on";
      quiet = true;
      global = true;
    }}
    ${mkSet {
      option = "utf8";
      value = "on";
      quiet = true;
      global = true;
      window = true;
    }}
    ${mkSet {
      option = "display-time";
      value = "4000";
      global = true;
    }}
    ${mkSet {
      option = "xterm-keys";
      value = "on";
      window = true;
    }}
    ${mkSet {
      option = "repeat-time";
      value = "300";
      server = true;
      global = true;
    }}
    # Border lines between panes are thicker
    # single -> single lines using ACS or UTF-8 characters
    # double -> double lines using UTF-8 characters
    # heavy  -> heavy lines using UTF-8 characters
    # simple -> simple ASCII characters
    # number -> the pane number
    ${mkSet {
      option = "pane-norder-lines";
      value = "single";
      global = true;
    }}
    # Indicate active pane by colouring only half of the border in windows with
    # exactly two panes, by displaying arrow markers, by drawing both or neither.
    # [off | colour | arrows | both]
    ${mkSet {
      option = "pane-border-indicators";
      value = "colour";
      global = true;
    }}
    # set status bar position
    ${mkSet {
      option = "status-position";
      value = "top";
      global = true;
    }}

    # binds
    # source tmux config file
    ${mkBind {
      key = "r";
      action = ''source-file "~/.config/tmux/tmux.conf" \; display 'Sourced tmux.conf' '';
    }}
    ${mkBind {
      key = "q";
      action = "kill-window";
    }}
    ${mkBind {
      key = "Q";
      action = "kill-session";
    }}
    ${mkBind {
      key = "t";
      action = ''new-window -c "#{pane_current_path"'';
    }}
    ${mkBind {
      key = "c";
      action = "clock-mode";
    }};
    # display panes numbers
    ${mkBind {
      key = "m";
      action = "display-message";
    }}
    ${mkBind {
      key = "M";
      action = "display-panes";
    }}
    ${mkBind {
      key = "b";
      action = "break-pane";
    }}
    ${mkBind {
      key = "B";
      action = "list-buffers";
    }}
    ${mkBind {
      key = "p";
      action = "select-pane -t:.+";
    }}
    # Search sessions using an fzf menu
    # Found this gem down here:
    # https://github.com/majjoha/dotfiles/blob/cd6f966d359e16b3a7c149f96d4edb8a83e769db/.config/tmux/tmux.conf#L41
    ${mkBind {
      key = "s";
      action = ''
        display-popup -E -w 75% -h 75% "\
        tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
        sed '/^$/d' |\
        fzf --reverse --header jump-to-session --preview 'tmux capture-pane -pt {}'  |\
        xargs tmux switch-client -t"
      '';
    }}
    # fzf menu to kill sessions
    # Credit: video below by Waylon Walker
    # https://www.youtube.com/watch?v=QWPyYx54JbE
    ${mkBind {
      key = "S";
      action = ''
        display-popup -E "\
        tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
        fzf --reverse -m --header=kill-session |\
        xargs -I {} tmux kill-session -t {}"
      '';
    }}
    ${mkBind {
      key = "Tab";
      action = "switch-client -l";
    }};
    # repeat bindings
    ${mkBind {
      key = "[";
      action = "previous-window";
      repeat = true;
    }}
    ${mkBind {
      key = "]";
      action = "next-window";
      repeat = true;
    }}
    # When pressing prefix+s to list sessions, I want them sorted by time
    # That way my latest used sessions show at the top of the list
    # -s starts with sessions collapsed (doesn't show windows)
    # -Z zooms the pane (don't understand what this does)
    # -O specifies the initial sort field: one of ‘index’, ‘name’, or ‘time’ (activity).
    # https://unix.stackexchange.com/questions/608268/how-can-i-force-tmux-to-sort-my-sessions-alphabetically
    # bind s choose-tree -Zs -O time
    # bind s choose-tree -Zs -O time -y
    ${mkBind {
      key = ",";
      action = ''choose-tree -Zs -O time -F "#{session_windows}"'';
    }}
    # -y at the end is a feature I requested so that the session is closed without confirmation
    # https://github.com/tmux/tmux/issues/4152
    # bind s choose-tree -Zs -O time -F "#{session_windows}" -y
    # bind s choose-tree -Zs -O time -F "#{?session_attached,#[fg=$linkarzu_color02],#[fg=$linkarzu_color03]}#{session_name}#[default]" -y
    # bind s choose-tree -Zs -O time -F "#{?session_attached,#[fg=$linkarzu_color02],#[fg=$linkarzu_color03]}" -y
    # splits
    ${mkUnbind "\""}
    ${mkUnbind "%"}
    ${mkBind {
      key = k;
      action = "split-window -vb -c '#{pane_current_path}'";
    }}
    ${mkBind {
      key = j;
      action = "split-window -v -c '#{pane_current_path}'";
    }}
    ${mkBind {
      key = h;
      action = "split-window -hb -c '#{pane_current_path}'";
    }}
    ${mkBind {
      key = l;
      action = "split-window -h -c '#{pane_current_path}'";
    }}
    # copy-mode-vi
    ${mkBind {
      key = "v";
      action = "send-keys -X begin-selection";
    }}
    ${mkBind {
      key = h;
      action = "send-keys -X cursor-left";
    }}
    ${mkBind {
      key = l;
      action = "send-keys -X cursor-right";
    }}
    ${mkBind {
      key = k;
      action = "send-keys -X cursor-up";
    }}
    ${mkBind {
      key = j;
      action = "send-keys -X cursor-down";
    }}
    ${mkBind {
      key = J;
      action = "send -X scroll-down";
    }}
    ${mkBind {
      key = K;
      action = "send -X scroll-up";
    }}
    ${mkBind {
      key = e;
      action = "send-keys -X next-word-end";
    }}
    ${mkBind {
      key = H;
      action = "send-keys -X start-of-line";
    }}
    ${mkBind {
      key = L;
      action = "send-keys -X end-of-line";
    }}
    ${mkBind {
      key = n;
      action = "send-keys -X search-again";
    }}
    ${mkBind {
      key = N;
      action = "send-keys -X search-reverse";
    }}
    ${mkBind {
      key = o;
      action = "send-keys -X other-end";
    }}
    ${mkUnbind {
      key = "MouseDragEnd1Pane";
      table = "copy-mode-vi";
    }}
    # copy to X11 clipboard
    if -b 'command -v xsel > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xsel -i -b"'
    if -b '! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'
    # copy to macOS clipboard
    if -b 'command -v pbcopy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | pbcopy"'
    if -b 'command -v reattach-to-user-namespace > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"'
    # copy to Windows clipboard
    if -b 'command -v clip.exe > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | clip.exe"'
    if -b '[ -c /dev/clipboard ]' 'bind y run -b "tmux save-buffer - > /dev/clipboard"'
    ${mkBind {
      key = "C-g";
      action = ''        if-shell '[[ $(tmux showw synchronize-panes | cut -d\  -f2) == "on" ]]' \
                         'setw synchronize-panes off; set -g pane-border-style fg=magenta' \
                         'setw synchronize-panes on; set -g pane-border-style fg=red'
      '';
    }}
    ${mkBind {
      key = "C-b";
      action = ''        if-shell '[[ $(tmux show -g status | cut -d\  -f2) == "on" ]]' \
                         'set -g status off' \
                         'set -g status on'
      '';
    }}

    # vim tmux navigation
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
    # bind-key -n C-${h} if-shell "$is_vim" 'send-keys C-${h}'  'select-pane -L'
    # bind-key -n C-${j} if-shell "$is_vim" 'send-keys C-${j}'  'select-pane -D'
    # bind-key -n C-${k} if-shell "$is_vim" 'send-keys C-${k}'  'select-pane -U'
    # bind-key -n C-${l} if-shell "$is_vim" 'send-keys C-${l}'  'select-pane -R'

    bind-key -n C-q if-shell "$is_vim" 'send-keys C-q'  'kill-pane'

    # bind-key -n C-Left if-shell "$is_vim" 'send-keys C-Left' 'resize-pane -L 3'
    # bind-key -n C-Down if-shell "$is_vim" 'send-keys C-Down' 'resize-pane -D 3'
    # bind-key -n C-Up if-shell "$is_vim" 'send-keys C-Up' 'resize-pane -U 3'
    # bind-key -n C-Right if-shell "$is_vim" 'send-keys C-Right' 'resize-pane -R 3'

    # tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
    # if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    #     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
    # if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    #     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

    # bind-key -T copy-mode-vi 'C-${h}' select-pane -L
    # bind-key -T copy-mode-vi 'C-${j}' select-pane -D
    # bind-key -T copy-mode-vi 'C-${k}' select-pane -U
    # bind-key -T copy-mode-vi 'C-${l}' select-pane -R
    # bind-key -T copy-mode-vi 'C-\' select-pane -l

    ${optionalString isDarwin ''
      set-option -g default-command "${getExe' pkgs.reattach-to-user-namespace "reattach-to-user-namespace"} -l ${shell}"
    ''}
  '';
}
