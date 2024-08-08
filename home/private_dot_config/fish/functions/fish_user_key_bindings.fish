function fish_user_key_bindings
    set -g fish_key_bindings fish_vi_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind yy fish_clipboard_copy
    bind p fish_clipboard_paste
    bind N beginning-of-line
    bind O end-of-line
    bind I up-or-search
    bind E down-or-search
    bind o forward-char
    bind n backward-char
    bind i up-or-search
    bind e down-or-search
    bind E end-of-line delete-char
    bind I man\ \(commandline\ -t\)\ 2\>/dev/null\;\ or\ echo\ -n\ \\a
    bind j forward-single-char forward-word backward-char
    bind J forward-bigword backward-char
    bind k kill-line
    bind K kill-whole-line
    bind -m insert h repaint-mode
    bind -m insert H beginning-of-line repaint-mode
    bind -m insert l insert-line-under repaint-mode
    bind -m insert L insert-line-over repaint-mode
    bind -M visual n backward-char
    bind -M visual o forward-char
    bind -M visual e down-line
    bind -M visual i up-line
    bind -M visual j forward-word
    bind -M viusal J forward-bigword
    bind -M viusal l swap-selection-start-stop repaint-mode

end
