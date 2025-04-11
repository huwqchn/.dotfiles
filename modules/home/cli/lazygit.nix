{
  config,
  lib,
  ...
}: let
  shellAliases = {"lg" = "lazygit";};
  cfg = config.my.lazygit;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.lazygit = {
    enable = mkEnableOption "lazygit";
  };
  config = mkIf cfg.enable {
    home.shellAliases = shellAliases;
    # programs.nushell.shellAliases = shellAliases;
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          authorColors = {};
          branchColors = {};
          scrollHeight = 2;
          scrollPastBottom = true;
          mouseEvents = true;
          skipDiscardChangeWarning = false;
          skipStashWarning = false;
          sidePanelWidth = 0.3333;
          expandFocusedSidePanel = false;
          mainPanelSplitMode = "flexible";
          language = "auto";
          timeFormat = "02 Jan 06 15:04 MST";
          nerdFontsVersion = 3;
          theme = {
            lightTheme = false;
            activeBorderColor = ["green" "bold"];
            inactiveBorderColor = ["black"];
            optionsTextColor = ["white"];
            selectedLineBgColor = ["reverse"];
            selectedRangeBgColor = ["blue"];
            cherryPickedCommitBgColor = ["cyan"];
            cherryPickedCommitFgColor = ["blue"];
            unstagedChangesColor = ["red"];
          };
          commitLength.show = true;
          skipNoStagedFilesWarning = false;
          showListFooter = true;
          showFileTree = true;
          showRandomTip = true;
          showCommandLog = true;
          showBottomLine = true;
          showIcons = true;
          commandLogSize = 8;
          splitDiff = "auto";
        };
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never";
            useConfig = false;
          };
          commit.signOff = false;
          merging = {
            manualCommit = false;
            args = "";
          };
          skipHookPrefix = "WIP";
          autoFetch = true;
          autoRefresh = true;
          branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --";
          allBranchesLogCmd = "git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium";
          overrideGpg = false;
          disableForcePushing = false;
          parseEmoji = false;
          log = {
            order = "topo-order";
            showGraph = "when-maximised";
            showWholeGraph = false;
          };
          diffContextSize = 3;
        };
        update = {
          method = "prompt";
          days = 14;
        };
        refresher = {
          refreshInterval = 10;
          fetchInterval = 60;
        };
        reporting = "undetermined";
        splashUpdatesIndex = 0;
        confirmOnQuit = false;
        quitOnTopLevelReturn = false;
        keybinding = {
          universal = {
            quit = "q";
            quit-alt1 = "<c-c>";
            return = "<esc>";
            quitWithoutChangingDirectory = "Q";
            togglePanel = "<tab>";
            prevItem = "<up>";
            nextItem = "<down>";
            prevItem-alt = "i";
            nextItem-alt = "e";
            prevPage = ",";
            nextPage = ".";
            scrollLeft = "N";
            scrollRight = "O";
            gotoTop = "<";
            gotoBottom = ">";
            prevBlock = "<left>";
            nextBlock = "<right>";
            prevBlock-alt = "n";
            nextBlock-alt = "o";
            nextBlock-alt2 = "<tab>";
            prevBlock-alt2 = "<backtab>";
            jumpToBlock = ["1" "2" "3" "4" "5"];
            nextMatch = "k";
            prevMatch = "K";
            startSearch = "/";
            optionMenu = "x";
            optionMenu-alt1 = "?";
            select = "<space>";
            goInto = "<enter>";
            confirm = "<enter>";
            confirm-alt1 = "y";
            remove = "d";
            new = "a";
            edit = "h";
            openFile = "H";
            scrollUpMain = "<pgup>";
            scrollDownMain = "<pgdown>";
            # scrollUpMain-alt1 = "I";
            # scrollDownMain-alt1 = "E";
            scrollUpMain-alt2 = "<c-u>";
            scrollDownMain-alt2 = "<c-d>";
            executeShellCommand = ":";
            createRebaseOptionsMenu = "m";
            pushFiles = "P";
            pullFiles = "p";
            refresh = "R";
            createPatchOptionsMenu = "<c-p>";
            nextTab = "]";
            prevTab = "[";
            nextScreenMode = "+";
            prevScreenMode = "_";
            undo = "u";
            redo = "<c-r>";
            filteringMenu = "<c-f>";
            diffingMenu = "W";
            diffingMenu-alt = "<c-e>";
            copyToClipboard = "Y";
            openRecentRepos = "<c-o>";
            submitEditorText = "<enter>";
            appendNewline = "<a-enter>";
            extrasMenu = "@";
            toggleWhitespaceInDiffView = "<c-w>";
            increaseContextInDiffView = "}";
            decreaseContextInDiffView = "{";
          };
          status = {
            checkForUpdate = "U";
            recentRepos = "<enter>";
            allBranchesLogGraph = "a";
          };
          files = {
            commitChanges = "c";
            commitChangesWithoutHook = "w";
            amendLastCommit = "A";
            commitChangesWithEditor = "C";
            ignoreFile = "I";
            refreshFiles = "r";
            stashAllChanges = "s";
            viewStashOptions = "S";
            toggleStagedAll = "a";
            viewResetOptions = "D";
            fetch = "f";
            toggleTreeView = "`";
            openMergeTool = "M";
            openStatusFilter = "<c-b>";
          };
          branches = {
            createPullRequest = "l";
            viewPullRequestOptions = "L";
            copyPullRequestURL = "<c-y>";
            checkoutBranchByName = "c";
            forceCheckoutBranch = "F";
            rebaseBranch = "r";
            renameBranch = "R";
            mergeIntoCurrentBranch = "M";
            viewGitFlowOptions = "I";
            fastForward = "f";
            pushTag = "P";
            setUpstream = "U";
            fetchRemote = "f";
          };
          commits = {
            squashDown = "s";
            renameCommit = "r";
            renameCommitWithEditor = "R";
            viewResetOptions = "g";
            markCommitAsFixup = "f";
            createFixupCommit = "F";
            squashAboveCommits = "S";
            moveDownCommit = "<c-n>";
            moveUpCommit = "<c-p>";
            amendToCommit = "A";
            resetCommitAuthor = "a";
            pickCommit = "p";
            revertCommit = "t";
            cherryPickCopy = "c";
            cherryPickCopyRange = "C";
            pasteCommits = "v";
            tagCommit = "T";
            checkoutCommit = "<space>";
            resetCherryPick = "<c-R>";
            copyCommitAttributeToClipboard = "y";
            openLogMenu = "<c-l>";
            openInBrowser = "B";
          };
        };
        os = {
          edit = "nvim";
          editAtLine = "{{editor}} --server $NVIM --remote-tab {{filename}}";
          open = "open {{filename}}";
          openLink = "open {{link}}";
        };
        disableStartupPopups = false;
        customCommands = [
          {
            key = "<c-b>";
            command = "gh browse";
            context = "files";
          }
          {
            key = "<c-b>";
            command = ''gh browse "{{.SelectedLocalCommit.Sha}}"'';
            context = "files";
          }
        ];
        services = {};
        notARepository = "skip";
        promptToReturnFromSubprocess = true;
      };
    };
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".local/state/lazygit"];
    };
  };
}
