{
  config,
  lib,
  pkgs,
  ...
}: let
  shellAliases = {
    "g" = "git";
  };
  cfg = config.my.git;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.types) nullOr enum;
  inherit (config.home) homeDirectory;
in {
  options.my.git = {
    enable = mkEnableOption "git";
    diff = mkOption {
      type = nullOr (enum ["riff" "delta"]);
      default = "riff";
      description = "The git diff tool to use";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = config.my.fullName;
      userEmail = config.my.email;

      extraConfig = {
        color.ui = true;
        core.editor = "nvim";
        init.defaultBranch = "main";
        credential.helper = "store";
        github.user = "huwqchn";
        push.autoSetupRemote = true;
        pull.rebase = true;
        rebase = {
          autosquash = true;
          autostash = true;
          stat = true;
        };
        rerere = {
          autoupdate = true;
          enabled = true;
        };
        status.submoduleSummary = true;
      };

      delta = mkIf (cfg.diff == "delta") {
        enable = true;
        options = {
          features = mkDefault "side-by-side";
          navigate = true; # use n and N to move between diff sections
          line-numbers = true;
        };
      };

      # Use riff instead of delta
      riff.enable = cfg.diff == "riff";

      ignores = [".*.sw?" ".direnv/" ".envrc" "result*" "node_modules"];

      aliases = let
        log = "log --show-notes='*' --abbrev-commit --pretty=format:'%Cred%h %Cgreen(%aD)%Creset -%C(bold red)%d%Creset %s %C(bold blue)<%an>% %Creset' --graph";
      in {
        # common aliases
        # add
        a = "add --patch";
        ad = "add";

        # branch
        b = "branch";
        ba = "branch -a"; # list remote branches
        bd = "branch --delete";
        bD = "branch -D";

        # commit
        c = "commit";
        ca = "commit --amend";
        cm = "commit --message";

        co = "checkout";
        cb = "checkout -b";
        pc = "checkout --patch";

        cl = "clone";

        # diff
        d = "diff";
        ds = "diff --staged";
        dc = "diff --cached";

        # show
        h = "show";
        h1 = "show HEAD^";
        h2 = "show HEAD^^";
        h3 = "show HEAD^^^";
        h4 = "show HEAD^^^^";
        h5 = "show HEAD^^^^^";

        # push & pull
        P = "push";
        Pf = "push --force-with-lease";
        p = "pull";
        pr = "pull --rebase";
        # rebase
        r = "rebase";
        ra = "rebase --abort";
        rc = "rebase --continue";
        ri = "rebase --interactive";
        # reset
        R = "reset";
        Rh = "reset --hard";

        # log
        l = log;
        la = "${log} --all";
        ll = "${log} --numstat";
        ls = "${log} --patch";

        # status
        s = "status --short --branch";
        st = "status";
        # stash
        S = "stash";
        Sc = "stash clear";
        Sh = "stash show --patch";
        Sl = "stash list";
        Sp = "stash pop";
        # ls = ''
        #   log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'';
        # ll = ''
        #   log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'';

        # aliases for submodule
        update = "submodule update --init --recursive";
        foreach = "submodule foreach";
      };
    };

    home = {
      inherit shellAliases;

      packages = with pkgs; [
        # actions runner for github actions
        # act
        # actionlint
        # action-validator
        # for .gitignore
        gibo
      ];

      # `programs.git` will generate the config file: ~/.config/git/config
      # to make git use this config file, `~/.gitconfig` should not exist!
      #
      #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
      activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
        rm -f ~/.gitconfig
      '';
    };

    age.secrets.git-credentials = {
      rekeyFile = ./secrets/git-credentials.age;
      path = "${homeDirectory}/.git-credentials";
      symlink = false;
    };
  };
}
