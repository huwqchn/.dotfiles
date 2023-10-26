function fish_user_key_bindings
    set -g fish_key_bindings fish_vi_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind yy fish_clipboard_copy
    bind p fish_clipboard_paste
    bind N beginning-of-line
    bind O end-of-line
    bind o forward-char
    bind n backward-char
    bind i history-search-backward
    bind e history-search-forward
    bind -M default -m insert h repaint-mode
    bind -M default -m insert H beginning-of-line repaint-mode
    bind -M default -m insert l insert-line-under repaint-mode
    bind -M default -m insert L insert-line-over repaint-mode
    bind -M visual n backward-char
    bind -M visual o forward-char
    bind -M visual e down-or-search
    bind -M visual i up-or-search
    bind -M insert , accept-autosuggestion
end
