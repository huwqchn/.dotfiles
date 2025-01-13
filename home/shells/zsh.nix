{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";
    autosuggestion = {
      enable = true;
    };
    enableCompletion = true;
    zsh-abbr = {
      enable = true;
      abbreviations = {
        c = "clear";
        Q = "shutdown -h now";
        R = "reboot";
        mv = "mv -iv";
        cp = "cp -riv";
        mkdir = "mkdir -vp";
        rmdir = "rmdir -vp";
        v = "nvim";
        lg = "lazygit";
        lzd = "lazydocker";
        ipy = "ipython";
        cc = "cc -Wall -Werror -Wextra";
        pc = "proxychains4";
        icat = "wezterm imgcat";
        ns = "netstat -tunlp";
        # cd
        ".." = "cd ..";
        "..." = "cd ../..";
        ".3" = "cd ../../..";
        ".4" = "cd ../../../..";
        ".5" = "cd ../../../../..";
        # git
        g = "git";
        gi = "git clone";
        gl = "git l --color | devmoji --log --color | less -rXF";
        gs = "git st";
        gb = "git checkout -b";
        gc = "git commit";
        gca = "git commit --amend -a --no-edit";
        gpr = "git pr checkout";
        gm = "git branch -l main | rg main > /dev/null 2>&1 && git checkout main || git checkout master";
        gcp = "git commit -p";
        gP = "git push";
        gp = "git pull";
        ggc = "git reflog expire --expire-unreachable=now --all; and git gc --prune=now";
        # tmux
        t = "tmux";
        tc = "tmux attach";
        ta = "tmux attact -t";
        tad = "tmux attact -d -t";
        ts = "tmux new -s";
        tl = "tmux ls";
        tk = "tmux kill-session -t";
        # trashy
        rp = "trash put";
        rl = "trash list";
        rr = "trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force";
        re = "trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash empty --match=exact --force";
        # systemctl
        s = "systemctl";
        su = "systemctl --user";
        ss = "systemctl status";
        sl = "systemctl --type service --state running";
        slu = "systemctl --user --type service --state running";
        se = "sudo systemctl enable";
        sd = "sudo systemctl disable";
        sen = "sudo systemctl enable --now";
        sdn = "sudo systemctl disable --now";
        sr = "sudo systemctl restart";
        so = "sudo systemctl stop";
        sa = "sudo systemctl start";
        sf = "systemctl --failed --all";
        # journalctl
        j = "journalctl";
        jb = "journalctl -b";
        jf = "journalctl --follow";
        jg = "journalctl -b --grep";
        ju = "journalctl --unit";
      };
    };
  };
}
