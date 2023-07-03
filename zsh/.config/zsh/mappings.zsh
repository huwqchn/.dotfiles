function zle_eval {
    echo -en "\e[2K\r"
    eval "$@"
    zle redisplay
}

function openlazygit {
    zle_eval lazygit
}

zle -N openlazygit; bindkey "^l" openlazygit

# lfcd () {
#     tmp="$(mktemp)"
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

# bindkey -s '^o' 'lfcd\n'

# function openlazynpm {
#     zle_eval lazynpm
# }
#
# zle -N openlazynpm; bindkey "^N" openlazynpm

# function openncmpcpp {
# 		zle_eval ncmpcpp
# }
#
# zle -N openncmpcpp; bindkey "^N" openncmpcpp
#
