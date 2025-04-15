{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) optionalAttrs;
  cfg = config.my.fish;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in {
  options.my.fish = {
    enable = mkEnableOption "fish" // {default = config.my.shell == "fish";};
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "fzf-fish";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
        {
          name = "forgit";
          inherit (pkgs.fishPlugins.forgit) src;
        }
        {
          name = "autopair";
          inherit (pkgs.fishPlugins.autopair) src;
        }
        {
          name = "sponge";
          inherit (pkgs.fishPlugins.sponge) src;
        }
        {
          name = "humantime-fish";
          inherit (pkgs.fishPlugins.humantime-fish) src;
        }
        {
          name = "colored-man-pages";
          inherit (pkgs.fishPlugins.colored-man-pages) src;
        }
        # {
        #   name = "fish-you-should-use";
        #   inherit (pkgs.fishPlugins.fish-you-should-use) src;
        # }
        {
          name = "bang-bang";
          inherit (pkgs.fishPlugins.bang-bang) src;
        }
      ];
      shellInit = ''
        set -gx fish_vi_force_cursor 1
        set -gx fish_cursor_default block
        set -gx fish_cursor_insert line blink
        set -gx fish_cursor_visual block
        set -gx fish_cursor_replace_one underscore
        set fish_emoji_width 2

        abbr -a --position anywhere --set-cursor -- -h "-h 2>&1 | bat --plain --language=help"
      '';
      shellAbbrs =
        {
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
        }
        // optionalAttrs isLinux {
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
      functions = {
        extract = {
          body = ''
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
          '';
        };
        # fish_greeting = {body = "fastfetch";};
        backup = {
          argumentNames = "filename";
          body = "cp $filename $filename.bak";
        };
        restore = {
          argumentNames = "filename";
          body = "mv $filename (echo $filename | sed s/.bak//)";
        };
        start = {
          body = ''
            set service_name $argv[1]

            # Start the service
            sudo systemctl start $service_name

            # Wait for the service to become active
            while true
                if systemctl is-active --quiet $service_name
                    break
                else
                    echo "Waiting for service to start..."
                    sleep 1
                end
            end

            # Optionally, show some of the recent logs for the service
            journalctl -u $service_name --no-pager -n 10
          '';
        };
        fish_user_key_bindings = {
          body = ''
            set -g fish_key_bindings fish_vi_key_bindings
            fish_default_key_bindings -M insert
            fish_vi_key_bindings --no-erase insert
            bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
            bind yy fish_clipboard_copy
            bind p fish_clipboard_paste
            bind N beginning-of-line
            bind O end-of-line
            bind I up-or-search
            bind E down-or-search
            bind o forward-char
            bind n backward-char
            bind i up-or-search
            bind e down-or-search
            bind E end-of-line delete-char
            bind I man\ \(commandline\ -t\)\ 2\>/dev/null\;\ or\ echo\ -n\ \\a
            bind j forward-single-char forward-word backward-char
            bind J forward-bigword backward-char
            bind k kill-line
            bind K kill-whole-line
            bind -m insert h repaint-mode
            bind -m insert H beginning-of-line repaint-mode
            bind -m insert l insert-line-under repaint-mode
            bind -m insert L insert-line-over repaint-mode
            bind -M visual n backward-char
            bind -M visual o forward-char
            bind -M visual e down-line
            bind -M visual i up-line
            bind -M visual j forward-word
            bind -M viusal J forward-bigword
            bind -M viusal l swap-selection-start-stop repaint-mode
          '';
        };
      };
    };

    home.persistence."/persist${config.home.homeDirectory}".files = [
      ".local/share/fish/fish_history"
    ];
  };
}
