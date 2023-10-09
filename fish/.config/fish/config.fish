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
