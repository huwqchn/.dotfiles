{ config, ... }: {
  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
  ];
  programs.fish {
    enable = true;
    interactiveShellInit = ''
      neofetch
    '';
    shellAbbrs = {
      c = "clear";
      Q = "shutdown -h now";
      R = "reboot";
      mv = "mv -iv";
      cp = "cp -riv";
      mkdir = "mkdir -vp";
      rmdir = "rmdir -vp";
      j = "yazi";
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
      jb = "journalctl -b";
      jf = "journalctl --follow";
      jg = "journalctl -b --grep";
      ju = "journalctl --unit";
    };
  }
}