ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# plugins
# zinit ice wait lucid
# zinit load zdharma-continuum/history-search-multi-word

# SSH-AGENT
zinit light bobsoppe/zsh-ssh-agent
zinit light zdharma-continuum/fast-syntax-highlighting
# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zhistory"
HISTSIZE=290000
SAVEHIST=$HISTSIZE
zinit ice wait="0a" lucid atload="_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
bindkey ',' autosuggest-accept
# ZOXIDE
zinit ice wait="0" lucid from="gh-r" as="program" pick="zoxide-*/zoxide -> zoxide" cp="zoxide-*/completions/_zoxide -> _zoxide" atclone="./zoxide init zsh > init.zsh" atpull="%atclone" src="init.zsh"
zinit light ajeetdsouza/zoxide
# HISTORY
zinit ice wait="0b" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'e' history-substring-search-up
bindkey -M vicmd 'i' history-substring-search-down
zinit light zsh-users/zsh-history-substring-search
# TAB COMPLETIONS
zinit ice wait="0b" lucid blockf
zinit light zsh-users/zsh-completions
# zstyle ':completion:*' completer _expand _complete _ignored _approximate
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*' menu select=2
# zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# zstyle ':completion:*:descriptions' format '-- %d --'
# zstyle ':completion:*:processes' command 'ps -au$USER'
# zstyle ':completion:complete:*:options' sort false
# zstyle ':fzf-tab:complete:_zlua:*' query-string input
# zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
# zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
# zstyle ":completion:*:git-checkout:*" sort false
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # FZF
# zinit ice from="gh-r" as="command" bpick="*linux_amd64*"
# zinit light junegunn/fzf
# # FZF BYNARY AND TMUX HELPER SCRIPT
# zinit ice lucid wait'0c' as="command" id-as="junegunn/fzf-tmux" pick="bin/fzf-tmux"
# zinit light junegunn/fzf
# # BIND MULTIPLE WIDGETS USING FZF
# zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as="junegunn/fzf_completions" pick="/dev/null"
# zinit light junegunn/fzf
# # FZF-TAB
# zinit ice wait="1" lucid
# zinit light Aloxaf/fzf-tab

zinit wait="0" lucid light-mode for \
    hlissner/zsh-autopair \
    hchbaw/zce.zsh \
    wfxr/forgit

# TODO: add zinit auto install cmdline tools, git, nvim, tmux, ezd, fzf, etc

# RIPGREP
zinit ice from="gh-r" as="program" bpick="*amd64.deb" pick="usr/bin/rg"
zinit light BurntSushi/ripgrep
# NEOVIM
zinit ice from="gh-r" as="program" bpick="*linux64.tar.gz" ver="nightly" pick="nvim-linux64/bin/nvim" atload="alias v=nvim"
zinit light neovim/neovim
# LAZYGIT
zinit ice lucid wait="0" as="program" from="gh-r" bpick="*Linux_x86_64*" pick="lazygit" atload="alias lg='lazygit'"
zinit light jesseduffield/lazygit
# LAZYDOCKER
zinit ice lucid wait="0" as="program" from="gh-r" bpick="*Linux_x86_64*" pick="lazydocker" atload="alias lzd='lazydocker'"
zinit light jesseduffield/lazydocker
# FD
zinit ice as="command" from="gh-r" bpick="*amd64.deb" pick="usr/bin/fd"
zinit light sharkdp/fd
# DELTA
zinit ice lucid wait="0" as="program" from="gh-r" bpick="*amd64.deb" pick="usr/bin/delta"
zinit light dandavison/delta
# DUST
zinit ice wait="2" lucid from="gh-r" as="program" bpick="*amd64.deb" pick="usr/bin/dust" atload="alias du=dust"
zinit light bootandy/dust
# SAD
zinit ice from="gh-r" as="command"
zinit light ms-jpq/sad
