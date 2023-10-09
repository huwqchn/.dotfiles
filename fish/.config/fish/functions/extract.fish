function extract
    if test -f $argv[1]
        switch $argv[1]
            case "*.tar.bz2"
                tar xjf $argv[1]
            case "*.tar.gz"
                tar xzf $argv[1]
            case "*.bz2"
                bunzip2 $argv[1]
            case "*.rar"
                unrar x $argv[1]
            case "*.gz"
                gunzip $argv[1]
            case "*.tar"
                tar xf $argv[1]
            case "*.tbz2"
                tar xjf $argv[1]
            case "*.tgz"
                tar xzf $argv[1]
            case "*.zip"
                unar $argv[1]
            case "*.Z"
                uncompress $argv[1]
            case "*.7z"
                7z x $argv[1]
            case "*.deb"
                ar x $argv[1]
            case "*.tar.xz"
                tar xf $argv[1]
            case "*.tar.zst"
                tar xf $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted using ex()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end
