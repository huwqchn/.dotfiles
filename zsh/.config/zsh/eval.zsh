eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(navi widget zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"
if  [ -z "$TMUX" ]
then
  tmux attach -t main || tmux new -s main
fi
# source /opt/anaconda/bin/activate root
