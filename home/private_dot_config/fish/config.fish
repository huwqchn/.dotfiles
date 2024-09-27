set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx BROWSER microsoft-edge-dev
set -gx TERMINAL wezterm
set -gx THEME tokyonight

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
fish_add_path ~/.local/share/bin

set -x LD_LIBRARY_PATH /usr/lib $LD_LIBRARY_PATH

# emscripten
fish_add_path /usr/lib/emsdk
fish_add_path /usr/lib/emsdk/upstream/emscripten

# Go
set -x GO111MODULE on
set -x GOPROXY https://goproxy.cn
set -x GOPATH ~/go
fish_add_path $GOPATH $GOPATH/bin

# FISH
set fish_emoji_width 2

# CFLAGS
# set -x CFLAGS "-Wall -Werror -Wextra"
set -x CFLAGS "-Wall -O2"
set -x CXXFLAGS "-Wall -O2"

# Ripgrep
set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc

# gtags
set -x GTAGSLABEL native-pygments
set -x GTAGSCONF $HOME/.config/gtags/gtags.conf

# tmux
set -x TMUX_TMPDIR $HOME/.tmux/tmp

# Exports
set -x RUST_BACKTRACE 1
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
alias rn rnr
alias sysctl systeroid
alias uniq huniq
alias email himalaya
# get top process eating memory
alias psmem 'ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu
alias pscpu 'ps auxf | sort -nr -k 3 | head -5'

# toggle eww
alias eww-toggle '$HOME/.config/eww/toggle'

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
abbr f neofetch
abbr ncdu 'ncdu --color dark'
abbr y yazi
abbr v nvim
abbr gg gitui
abbr ze zellij
abbr lg lazygit
abbr lzd lazydocker
abbr ipy ipython
abbr cc 'cc -Wall -Werror -Wextra'
abbr pc proxychains4
abbr icat "wezterm imgcat"
abbr fm frogmouth
abbr ns 'netstat -tunlp'
abbr ex extract
abbr nb newsboat

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# shortcuts for functions
abbr bk backup
abbr re restore


abbr git hub
abbr topgit topgrade --only git_repos
abbr g hub
abbr gi "hub clone"
abbr gl 'hub l --color | devmoji --log --color | less -rXF'
abbr gs "hub st"
abbr gb "hub checkout -b"
abbr gc "hub commit"
abbr gpr "hub pr checkout"
abbr gm "hub branch -l main | rg main > /dev/null 2>&1 && hub checkout main || hub checkout master"
abbr gcp "hub commit -p"
abbr gP "hub push"
abbr gp "hub pull"

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
abbr se "sudo systemctl enable"
abbr sd "sudo systemctl disable"
abbr sen "sudo systemctl enable --now"
abbr sdn "sudo systemctl disable --now"
abbr sr "sudo systemctl restart"
abbr so "sudo systemctl stop"
abbr sa "sudo systemctl start"
abbr sf "systemctl --failed --all"

# journalctl
abbr j journalctl
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
abbr pl "paru -Q"
abbr pf "paru -Ql"
abbr po "paru -Qo"

# chezmoi
abbr cz chezmoi
abbr czi "chezmoi init"
abbr czia 'chezmoi init --apply'
abbr cza "chezmoi add --verbose"
abbr czae "chezmoi add --encrypt --verbose"
abbr czaf "chezmoi add --follow --verbose"
abbr cze "chezmoi edit --apply"
abbr czz "cd ~/.local/share/chezmoi/"
abbr czp "chezmoi apply --verbose"
abbr czd "chezmoi diff"
abbr czc "chezmoi chattr"
abbr czm "chezmoi merge"
abbr czma "chezmoi merge-all"
abbr czl "chezmoi list"
abbr czu "chezmoi update --verbose"
abbr czr "chezmoi remove --verbose"
abbr czf "chezmoi forget --verbose"
