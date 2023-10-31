alias c='clear'
alias neofetch='neofetch --ascii $HOME/.config/neofetch/predator'
alias lg='lazygit'
alias lzd='lazydocker'
# alias lnpm ='lazynpm'
alias t='tmux'
alias ipy="ipython"
alias cdiff='colordiff'
alias E="emacsclient -c -a 'emacs'"
alias e="emacs -nw"
alias ra="ranger"
if [[ $(uname) == 'Darwin' ]]; then
  alias ed='/opt/homebrew/bin/emacs --daemon &'
elif [[ $(uname) == 'Linux' ]]; then
  alias pm="pulsemixer"
	alias ep='export all_proxy=http://127.0.0.1:7890'
  alias ed='/usr/bin/emacs --daemon &'
	alias aic='ascii-image-converter'
	# alias x='xmodmap ~/.Xmodmap' # use keyd instead
	# alias xr='xrandr --output HDMI-1 --scale 1.12x1.50'
	# xrandr --output HDMI-1 --scale 2x2 --primary --output eDP-1 --auto --below HDMI-1
	alias lo='betterlockscreen'
  alias mkdir="mkdir -p --verbose"
  alias rmdir="rmdir -p --verbose"
  # alias convert2wallpaper="convert -resize $(xdpyinfo | grep dimensions | cut -d\  -f7 | cut -dx -f1)"
  alias pipes="pipes.sh"
fi
# light-weight sudo
alias sudo="doas"
alias sudoedit="doas rvim"
# alias doom='~/.emacs.d/bin/doom'
alias v='nvim'
alias ze="zellij"
alias ls="eza -aG --color=always --icons --group-directories-first"
alias la="eza -a --color=always --icons --group-directories-first"
alias ll="eza -al --color=always --icons --group-directories-first"
alias tree="lsd --tree"
alias cat="bat"
alias du="dust"
alias dot="chezmoi"
# rm improved
alias rm="rip"
# alias ps="procs"
alias hf="hyperfine"
# code analysis
alias tk="tokei"
# fast alternative to cut
# alias cut="choose"
# rename
alias rn="rnr"
# better sysctl
alias sysctl="systeroid"
# alias uniq
alias uniq="huniq"

# some git aliases
alias git="hub"
alias topgit="topgrade --only git_repos"
alias g="hub"
alias gl='hub l --color | devmoji --log --color | less -rXF'
alias gs="hub st"
alias gb="hub checkout -b"
alias gc="hub commit"
alias gpr="hub pr checkout"
alias gm="hub branch -l main | rg main > /dev/null 2>&1 && hub checkout main || hub checkout master"
alias gcp="hub commit -p"
alias gP="hub push"
alias gp="hub pull"

alias nc="ncmpcpp"
alias m="neomutt"
alias lzd="lazydocker"
alias nb="newsboat"
alias chwal="feh --bg-fill -no-fehbg"
alias cm="cmatrix"
alias gg="gitui"
alias top="btop"
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
# shutdown -h now
alias Q="shutdown -h now"
#reboot
alias R="reboot"

# shortcuts
# alias utar="tar -zxvf"
alias poly="~/.config/polybar/launch.sh"
alias cc="cc -Wall -Werror -Wextra"
alias pc="proxychains4"
alias icat="wezterm imgcat"
# alias sc="source /opt/anaconda/bin/activate root"
alias fm="frogmouth"
alias email="himalaya"
alias ns="netstat -tunlp"

# Function for extracting compressed files
ex () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar xjf $1  ;;
            *.tar.gz)   tar xzf $1  ;;
            *.bz2)      bunzip2 $1  ;;
            *.rar)      unrar x $1  ;;
            *.gz)       gunzip $1   ;;
            *.tar)      tar xf $1   ;;
            *.tbz2)     tar xjf $1  ;;
            *.tgz)      tar xzf $1  ;;
            *.zip)      unar $1    ;;
            *.Z)        uncompress $1 ;;
            *.7z)       7z x $1     ;;
            *.deb)      ar x $1     ;;
            *.tar.xz)   tar xf $1   ;;
            *.tar.zst)  tar xf $1   ;;
            *)          echo "'$1' cannot be extracted using ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# joshuto with cd
j() {
	ID="$$"
	mkdir -p /tmp/$USER
	OUTPUT_FILE="/tmp/$USER/joshuto-cwd-$ID"
	env joshuto --output-file "$OUTPUT_FILE" $@
	exit_code=$?

	case "$exit_code" in
		# regular exit
		0)
			;;
		# output contains current directory
		101)
			JOSHUTO_CWD=$(cat "$OUTPUT_FILE")
			cd "$JOSHUTO_CWD"
      rm "$OUTPUT_FILE"
			;;
		# output selected files
		102)
      cat "$OUTPUT_FILE"
      rm "$OUTPUT_FILE"
      ;;
		*)
			echo "Exit code: $exit_code"
			;;
	esac
}
