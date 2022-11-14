export XDG_CONFIG_HOME=$HOME/.config
export NVIM_BASE_DIR=XDG_CONFIG_HOME/nvim
export TERM=xterm-256color
export TERM_ITALICS=true
export EDITOR=nvim
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# export TERM=screen-256color-bce

export PATH="$HOME/.dotfiles/.bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
if [[ `uname` == 'Darwin' ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
	export PATH="$HOME/.nix-profile/bin:$PATH"
	export C_INCLUDE_PATH="/opt/homebrew/include:$C_INCLUDE_PATH"
	export CPLUS_INCLUDE_PATH="/opt/homebrew/include:$CPLUS_INCLUDE_PATH"
	export DYLD_LIBRARY_PATH="/usr/local/lib:$DYLD_LIBRARY_PATH"
	export DYLD_LIBRARY_PATH="/opt/homebrew/lib:$DYLD_LIBRARY_PATH"
	export LIBRARY_PATH="/usr/local/lib:$LIBRARY_PATH"
	export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"
	export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles
elif [[ `uname` == 'Linux' ]]; then
  export TERMINAL="alacritty"
  export PATH=$PATH:/snap/bin
	export GDK_SCALE=2
	export GDK_DPI_SCALE=0.5
	export QT_AUTO_SCREEN_SCALE_FACTOR=0
	export QT_SCALE_FACTOR=1
fi
