alias c='clear'
alias s='neofetch'
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
	alias ep='export all_proxy=http://127.0.0.1:7890'
  alias aic='ascii-image-converter'
  alias x='xmodmap ~/.Xmodmap'
  alias xr='xrandr --output HDMI-1 --scale 1.12x1.50'
fi
alias doom='~/.emacs.d/bin/doom'
alias v='nvim'
alias ls="exa -aG --color=always --icons --group-directories-first"
alias la="exa -a --color=always --icons --group-directories-first"
alias tree="lsd --tree"
alias cat="bat"
alias du="dust"

# some git aliases
alias gp="git push"
alias gP="git pull"
alias ga="git status"
alias gA="git add"
alias gc="git commit"
alias gC="git checkout"


alias nc="ncmpcpp"
alias m="neomutt"
alias d="lazydocker"
alias chwal="feh --bg-fill -no-fehbg"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# easier to read disk
alias df="df -h" # human-readable sizes
alias free="free -m" # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
