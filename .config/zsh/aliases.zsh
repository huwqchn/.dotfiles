alias c='clear'
# alias ls="colorls"
alias s='neofetch | lolcat'
alias lg='lazygit'
# alias lnpm ='lazynpm'
alias ra='ranger'
alias t='tmux'
alias ta='tmux a'
alias cdiff='colordiff'
alias e='emacs -nw'
if [[ `uname` == 'Darwin' ]]; then
	alias ep='export https_proxy=http://127.0.0.1:19180 && export http_proxy=http://127.0.0.1:19180'
elif [[ `uname` == 'Linux' ]]; then
	alias ep='export https_proxy=http://127.0.0.1:20171 && export http_proxy=http://127.0.0.1:20171'
fi
alias doom='~/.emacs.d/bin/doom'
alias v='nvim'
