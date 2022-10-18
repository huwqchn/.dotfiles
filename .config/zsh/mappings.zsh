function zle_eval {
    echo -en "\e[2K\r"
    eval "$@"
    zle redisplay
}

function openlazygit {
    zle_eval lazygit
}

zle -N openlazygit; bindkey "^G" openlazygit

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
