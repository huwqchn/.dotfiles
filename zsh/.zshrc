source ~/.config/zsh/theme.zsh
source ~/.config/zsh/env.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/vi.zsh
source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/zinit.zsh
source ~/.config/zsh/eval.zsh

# beeping is annoying
unsetopt BEEP

# # Check if neofetch is installed
# if command -v neofetch &> /dev/null; then
#     # Check if the configuration file exists
#     if [ -f $HOME/.config/neofetch/config_tokyonight.conf ]; then
#         neofetch --config $HOME/.config/neofetch/config_tokyonight.conf
#     else
#         neofetch
#     fi
# else
#     echo "neofetch is not installed."
# fi
