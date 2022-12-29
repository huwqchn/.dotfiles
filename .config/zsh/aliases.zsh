alias c='clear'
alias s='neofetch'
alias lg='lazygit'
# alias lnpm ='lazynpm'
alias ra='ranger'
alias t='tmux'
alias ipy="ipython"
alias cdiff='colordiff'
alias e='/usr/bin/emacs --daemon &'
if [[ $(uname) == 'Darwin' ]]; then
	alias ep='export https_proxy=http://127.0.0.1:19180 && export http_proxy=http://127.0.0.1:19180'
elif [[ $(uname) == 'Linux' ]]; then
	alias ep='export all_proxy=http://127.0.0.1:7890'
  alias aic='ascii-image-converter'
  # alias x='xmodmap ~/.Xmodmap' # use keyd instead
  alias xr='xrandr --output HDMI-1 --scale 1.12x1.50'
  alias lo='betterlockscreen'
fi
alias doom='~/.emacs.d/bin/doom'
alias v='nvim'
alias ls="exa -aG --color=always --icons --group-directories-first"
alias la="exa -a --color=always --icons --group-directories-first"
alias tree="lsd --tree"
alias cat="bat"
alias du="dust"
alias mkdir="mkdir -p --verbose"
alias rmdir="rmdir -p --verbose"

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
alias cm="cmatrix"
alias g="gitui"
alias top="btop"
alias lf="lfrun"
# confirm before overwriting something
# alias cp="cp -i"
# alias mv="mv -i"
# alias rm="rm -i"

# easier to read disk
alias df="df -h" # human-readable sizes
# alias free="free" # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# source ~/.zshrc
alias S="source ~/.zshrc"
