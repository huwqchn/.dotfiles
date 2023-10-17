set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx BROWSER brave


# Cursor styles
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

# PATH
set -x fish_user_paths
fish_add_path ~/.dotfiles/.bin
fish_add_path ~/.local/share/gem/ruby/3.0.0/bin
fish_add_path ~/.local/share/nvim/mason/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /snap/bin
fish_add_path ~/.emacs.d/bin

# Go
set -x GOPATH ~/go
fish_add_path $GOPATH $GOPATH/bin

# FISH
set fish_emoji_width 2

# Exports
set -x LESS -rF
set -x COMPOSE_DOCKER_CLI_BUILD 1
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x DOTDROP_AUTOUPDATE no
set -x MANPAGER "nvim +Man!"
set -x MANROFFOPT -c
set -x OPENCV_LOG_LEVEL ERROR

abbr -a --position anywhere --set-cursor -- -h "-h 2>&1 | bat --plain --language=help"
# alias
alias cdiff colordiff
alias sudo doas
alias sudoedit "doas rvim"
alias ls "eza -aG --color=always --icons --group-directories-first"
alias la "eza -a --color=always --icons --group-directories-first"
alias ll "eza -al --color=always --icons --group-directories-first"
alias tree "lsd --tree"
alias top btop
alias cat bat
alias du dust
alias dot chezmoi
alias rm rip
alias rn rnr
alias sysctl systeroid
alias uniq huniq
alias email himalaya
# get top process eating memory
alias psmem 'ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu
alias pscpu 'ps auxf | sort -nr -k 3 | head -5'

# shortcuts
abbr c clear
abbr Q 'shutdown -h now '
abbr R reboot
abbr mv 'mv -iv'
abbr cp 'cp -riv'
abbr mkdir 'mkdir -vp'
abbr rmdir 'rmdir -vp'
abbr ka killall
abbr hf hyperfine
abbr tk tokei
abbr df 'df -h'
abbr neofetch 'neofetch --ascii $HOME/.config/neofetch/predator'
abbr ncdu 'ncdu --color dark'
abbr j joshuto
abbr v nvim
abbr g gitui
abbr ze zellij
abbr lg lazygit
abbr lzd lazydocker
abbr ipy ipython
abbr cc 'cc -Wall -Werror -Wextra'
abbr pc proxychains4
abbr icat 'kitty +kitten icat'
abbr fm frogmouth
abbr ns 'netstat -tunlp'
abbr ex extract

# Tmux
abbr t tmux
abbr tc 'tmux attach'
abbr ta 'tmux attach -t'
abbr tad 'tmux attach -d -t'
abbr ts 'tmux new -s'
abbr tl 'tmux ls'
abbr tk 'tmux kill-session -t'

# systemctl
abbr s systemctl
abbr su "systemctl --user"
abbr ss "command systemctl status"
abbr sl "systemctl --type service --state running"
abbr slu "systemctl --user --type service --state running"
abbr se "sudo systemctl enable --now"
abbr sd "sudo systemctl disable --now"
abbr sr "sudo systemctl restart"
abbr so "sudo systemctl stop"
abbr sa "sudo systemctl start"
abbr sf "systemctl --failed --all"

# journalctl
abbr jb "journalctl -b"
abbr jf "journalctl --follow"
abbr jg "journalctl -b --grep"
abbr ju "journalctl --unit"

# arch package manager
abbr P 'sudo pacman'
abbr Pi "sudo pacman -S"
abbr Pr "sudo pacman -Rns"
abbr Ps "sudo pacman -Ss"
abbr Pl "sudo pacman -Q"
abbr Pf "sudo pacman -Ql"
abbr Po "sudo pacman -Qo"
abbr p paru
abbr pi "paru -S"
abbr pr "paru -Rns"
abbr ps "paru -Ss"
abbr pl "paru -Q"
abbr pf "paru -Ql"
abbr po "paru -Qo"
