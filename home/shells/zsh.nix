{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.zsh;
in {
  options.my.zsh = {
    enable = mkEnableOption "zsh" // {default = config.my.shell == "zsh";};
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      defaultKeymap = "viins";
      autosuggestion = {enable = true;};
      enableCompletion = true;
      syntaxHighlighting = {enable = true;};
      autocd = true;
      dirHashes = {
        dot = "$HOME/.dotfiles";
        dow = "$HOME/Downloads";
        doc = "$HOME/Documents";
        one = "$HOME/OneDrive";
        desk = "$HOME/Desktop";
        pro = "$HOME/Projects";
        repo = "$HOME/Repos";
        pic = "$HOME/Pictures";
        work = "$HOME/Workspaces";
      };
      history = {
        ignoreDups = true;
        extended = true;
        share = true;
        save = 10000;
      };
      historySubstringSearch = {enable = true;};
      completionInit = ''
        zstyle ':completion:*' completer _expand _complete _ignored _approximate
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':completion:*' menu select=2
        zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
        zstyle ':completion:*:descriptions' format '-- %d --'
        zstyle ':completion:*:processes' command 'ps -au$USER'
        zstyle ':completion:complete:*:options' sort false
        zstyle ':fzf-tab:complete:_zlua:*' query-string input
        zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
        zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
        zstyle ":completion:*:git-checkout:*" sort false
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      '';
      plugins = with pkgs; [
        {
          # Must be before plugins that wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
        {
          name = "zsh-nix-shell";
          src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "zsh-vi-mode";
          src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
        {
          name = "zsh-autosuggestions";
          src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "zsh-autopair";
          file = "zsh-autopair.plugin.zsh";
          src = fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "2ec3fd3c9b950c01dbffbb2a4d191e1d34b8c58a";
            hash = "sha256-Y7fkpvCOC/lC2CHYui+6vOdNO8dNHGrVYTGGNf9qgdg=";
          };
        }
        {
          name = "you-should-use";
          inherit (pkgs.zsh-you-should-use) src;
        }
      ];
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
  };
}
