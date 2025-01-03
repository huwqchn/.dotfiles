{config, ...}: {
  xdg.configFile = {
    "yazi/plugins/enter-or-open.yazi/init.lua".text = ''
      --- @sync entry
      return {
        entry = function()
          local h = cx.active.current.hovered
          ya.manager_emit(h and h.cha.is_dir and "enter" or "open", {})
        end,
      }
    '';
    "yazi/plugins/smart-enter.yazi/init.lua".text = ''
      --- @sync entry
      return {
        entry = function()
          local h = cx.active.current.hovered
          ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
        end,
      }
    '';
  };
  # terminal file manager
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      manager = {
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        linemode = "size";
        show_hidden = true;
      };
      preview = {
        tab_size = 2;
        max_width = 1000;
        max_height = 1000;
      };
      opener = {
        edit = [
          {
            run = "$EDITOR \"$@\"";
            block = true;
          }
          {
            run = "code \"$@\"";
            orphan = true;
          }
        ];
        play = [
          {run = "mpv \"$@\"";}
          {run = "iina \"$@\"";}
          {
            run = ''mediainfo \"$1\"; echo \"Press enter to exit\"; read'';
            block = true;
            desc = "Show media info";
          }
        ];
        archive = [
          {
            run = "unar \"$1\"";
            desc = "Extract here";
          }
          {
            run = "/Applications/MacZip.app/Contents/MacOS/MacZip \"$1\"";
            orphan = true;
            desc = "MacZip";
          }
        ];
      };

      rules = [
        {
          name = "*/";
          use = ["edit" "open" "reveal"];
        }
        {
          mime = "text/*";
          use = ["edit" "reveal"];
        }
        {
          mime = "image/*";
          use = ["open" "reveal"];
        }
        {
          mime = "video/*";
          use = ["play" "reveal"];
        }
        {
          mime = "audio/*";
          use = ["play" "reveal"];
        }
        {
          mime = "inode/x-empty";
          use = ["edit" "reveal"];
        }
        {
          mime = "application/json";
          use = ["edit" "reveal"];
        }
        {
          mime = "*/javascript";
          use = ["edit" "reveal"];
        }

        {
          mime = "application/zip";
          use = ["extract" "reveal" "archive"];
        }
        {
          mime = "application/gzip";
          use = ["extract" "reveal" "archive"];
        }
        {
          mime = "application/x-tar";
          use = ["extract" "reveal" "archive"];
        }
        {
          mime = "application/x-bzip";
          use = ["extract" "reveal" "archive"];
        }
        {
          mime = "application/x-bzip2";
          use = ["extract" "reveal" "archive"];
        }
        {
          mime = "application/x-7z-compressed";
          use = ["extract" "reveal" "archive"];
        }
        {
          mime = "application/x-rar";
          use = ["extract" "reveal" "archive"];
        }
        {
          mime = "*";
          use = ["open" "reveal"];
        }
      ];
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = ["w"];
          run = "shell \"$SHELL\" --block --confirm";
          desc = "Open shell here";
        }
        {
          on = ["W"];
          run = "tasks_show";
        }

        # Navigation
        {
          on = ["i"];
          run = "arrow -1";
        }
        {
          on = ["e"];
          run = "arrow 1";
        }

        {
          on = ["I"];
          run = "arrow -5";
        }
        {
          on = ["E"];
          run = "arrow 5";
        }

        {
          on = ["n"];
          run = ["leave"];
        }
        {
          on = ["o"];
          run = ["plugin --sync smart-enter"];
        }

        {
          on = ["N"];
          run = "back";
        }
        {
          on = ["O"];
          run = "forward";
        }

        {
          on = ["<C-u>"];
          run = "seek -5";
        }
        {
          on = ["<C-d>"];
          run = "seek 5";
        }

        {
          on = ["h"];
          run = "hidden toggle";
        }

        # Operation
        {
          on = ["l"];
          run = "link";
        }
        {
          on = ["L"];
          run = "link --relative";
        }

        # Find
        {
          on = ["k"];
          run = "find_arrow";
        }
        {
          on = ["K"];
          run = "find_arrow --previous";
        }

        # Tab
        {
          on = ["["];
          run = "tab_switch -1 --relative";
        }
        {
          on = ["]"];
          run = "tab_switch 1 --relative";
        }
      ];
      tasks.prepend_keymap = [
        {
          on = ["i"];
          run = "arrow -1";
        }
        {
          on = ["e"];
          run = "arrow 1";
        }
      ];
      select.prepend_keymap = [
        {
          on = ["i"];
          run = "arrow -1";
        }
        {
          on = ["e"];
          run = "arrow 1";
        }
        {
          on = ["I"];
          run = "arrow -5";
        }
        {
          on = ["E"];
          run = "arrow 5";
        }
      ];
      input.prepend_keymap = [
        {
          on = ["h"];
          run = "insert";
        }

        # Navigation
        {
          on = ["n"];
          run = "move -1";
        }
        {
          on = ["o"];
          run = "move 1";
        }

        {
          on = ["N"];
          run = "move -999";
        }
        {
          on = ["O"];
          run = "move 999";
        }

        {
          on = ["j"];
          run = "forward --end-of-word";
        }
      ];
      help.prepend_keymap = [
        # Navigation
        {
          on = ["i"];
          run = "arrow -1";
        }
        {
          on = ["e"];
          run = "arrow 1";
        }

        {
          on = ["I"];
          run = "arrow -5";
        }
        {
          on = ["E"];
          run = "arrow 5";
        }
      ];
      completion.prepend_keymap = [
        {
          on = ["<C-u>"];
          run = "arrow -1";
        }
        {
          on = ["<C-d>"];
          run = "arrow 1";
        }
      ];
    };
  };
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".local/state/yazi"];
  };
}
