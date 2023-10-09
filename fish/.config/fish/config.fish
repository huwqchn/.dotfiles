set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -x fish_user_paths
# PATH
fish_add_path ~/.dotfiles/.bin
fish_add_path ~/.local/share/gem/ruby/3.0.0/bin
fish_add_path ~/.local/share/nvim/mason/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /snap/bin

# FISH
set fish_emoji_width 2

# arch package manager
abbr P 'sudo pacman -'
abbr Pi "sudo pacman -S"
abbr Pr "sudo pacman -Rns"
abbr Ps "sudo pacman -Ss"
abbr Pl "sudo pacman -Q"
abbr Pf "sudo pacman -Ql"
abbr Po "sudo pacman -Qo"
abbr p 'paru -'
abbr pi "paru -S"
abbr pr "paru -Rns"
abbr ps "paru -Ss"
abbr pl "paru -Q"
abbr pf "paru -Ql"
abbr po "paru -Qo"
