{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.autopair
    fzf
    fishPlugins.grc
    grc
  ];
  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx fish_vi_force_cursor 1
      set -gx fish_cursor_default block
      set -gx fish_cursor_insert line blink
      set -gx fish_cursor_visual block
      set -gx fish_cursor_replace_one underscore
      set fish_emoji_width 2

      abbr -a --position anywhere --set-cursor -- -h "-h 2>&1 | bat --plain --language=help"
    '';
    shellAbbrs = {
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
      git = "hub";
      g = "hub";
      gi = "hub clone";
      gl = "hub l --color | devmoji --log --color | less -rXF";
      gs = "hub st";
      gb = "hub checkout -b";
      gc = "hub commit";
      gpr = "hub pr checkout";
      gm = "hub branch -l main | rg main > /dev/null 2>&1 && hub checkout main || hub checkout master";
      gcp = "hub commit -p";
      gP = "hub push";
      gp = "hub pull";
      # tmux
      t = "tmux";
      tc = "tmux attach";
      ta = "tmux attact -t";
      tad = "tmux attact -d -t";
      ts = "tmux new -s";
      tl = "tmux ls";
      tk = "tmux kill-session -t";
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
}
