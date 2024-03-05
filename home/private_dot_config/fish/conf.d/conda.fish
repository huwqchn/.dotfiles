# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/anaconda/bin/conda
    eval /opt/anaconda/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/anaconda/etc/fish/conf.d/conda.fish"
        . "/opt/anaconda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/anaconda/bin $PATH
    end
end

# don't add the conda prompt. This is done by starship
function __conda_add_prompt
end

# <<< conda initialize <<<
export TERMINFO=/usr/share/terminfo
