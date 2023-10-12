eval "$(zoxide init zsh)"
eval "$(starship init zsh --print-full-init)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(navi widget zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"
if  [ -z "$TMUX" ]
then
  tmux attach -t main || tmux new -s main
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# neofetch initialize
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
