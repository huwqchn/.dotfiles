{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.yazi;
  layouts = {
    qwerty = {
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      Left = "H";
      Down = "J";
      Up = "K";
      Right = "L";
      end = "e";
      next = "n";
      prev = "N";
      hide = "T";
      link = "o";
      Link = "O";
      insert = "i";
    };
    colemak = {
      left = "n";
      down = "e";
      up = "i";
      right = "o";
      Left = "N";
      Down = "E";
      Up = "I";
      Right = "O";
      end = "j";
      next = "k";
      prev = "K";
      hide = "h";
      link = "l";
      Link = "L";
      insert = "h";
    };
  };
  layout = layouts.${config.my.keyboard.layout or "qwerty"};
in {
  options.my.yazi = {
    enable = mkEnableOption "yazi";
  };

  config = mkIf cfg.enable {
    # terminal file manager
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      # enableNushellIntegration = true;
      plugins = with pkgs.yaziPlugins; {
        inherit starship;
        inherit sudo;
        inherit smart-enter;
        inherit smart-filter;
        inherit time-travel;
        inherit mount;
        inherit git;
        inherit chmod;
        inherit no-status;
      };
      initLua = ''
        require("starship"):setup()

        -- https://github.com/yazi-rs/plugins/tree/main/git.yazi
        th.git = th.git or {}

        th.git.added = ui.Style():fg("blue")
        th.git.added_sign = ""

        th.git.deleted = ui.Style():fg("red"):bold()
        th.git.deleted_sign = ""

        th.git.ignored = ui.Style():fg("gray")
        th.git.ignored_sign = ""

        th.git.modified = ui.Style():fg("green")
        th.git.modified_sign = ""

        th.git.untracked = ui.Style():fg("gray")
        th.git.untracked_sign = ""

        th.git.updated = ui.Style():fg("green")
        th.git.updated_sign = ""

        require("git"):setup()
        require("no-status"):setup()
      '';
      settings = {
        mgr = {
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
              run = ''$EDITOR "$@"'';
              block = true;
            }
            {
              run = ''code "$@"'';
              orphan = true;
            }
          ];
          play = [
            {run = ''mpv "$@"'';}
            {run = ''iina "$@"'';}
            {
              run = ''mediainfo \"$1\"; echo \"Press enter to exit\"; read'';
              block = true;
              desc = "Show media info";
            }
          ];
          archive = [
            {
              run = ''unar "$1"'';
              desc = "Extract here";
            }
            {
              run = ''/Applications/MacZip.app/Contents/MacOS/MacZip "$1"'';
              orphan = true;
              desc = "MacZip";
            }
          ];
        };
        # settings for plugins
        plugin = {
          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
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
        mgr.prepend_keymap = [
          {
            on = "F";
            run = "plugin smart-filter";
            desc = "Smart filter";
          }
          {
            on = "T";
            run = "plugin --sync max-preview";
            desc = "Maximize or restore the preview pane";
          }
          {
            on = ["c" "m"];
            run = "plugin chmod";
            desc = "Chmod on selected files";
          }
          {
            on = "w";
            run = ''shell "$SHELL" --block --confirm'';
            desc = "Open shell here";
          }
          {
            on = "W";
            run = "tasks_show";
          }

          # Navigation
          {
            on = layout.up;
            run = "arrow -1";
          }
          {
            on = layout.down;
            run = "arrow 1";
          }
          {
            on = layout.left;
            run = "leave";
          }
          {
            on = layout.right;
            run = "plugin smart-enter";
          }

          {
            on = layout.Left;
            run = "back";
          }
          {
            on = layout.Right;
            run = "forward";
          }

          {
            on = "<C-u>";
            run = "seek -5";
          }
          {
            on = "<C-d>";
            run = "seek 5";
          }

          {
            on = layout.hide;
            run = "hidden toggle";
          }

          # Operation
          {
            on = layout.link;
            run = "link";
          }
          {
            on = layout.Link;
            run = "link --relative";
          }

          # Find
          {
            on = layout.next;
            run = "find_arrow";
          }
          {
            on = layout.prev;
            run = "find_arrow --previous";
          }

          # Tab
          {
            on = "[";
            run = "tab_switch -1 --relative";
          }
          {
            on = "]";
            run = "tab_switch 1 --relative";
          }
          # diff
          {
            on = "<A-d>";
            run = "plugin diff";
            desc = "Diff";
          }
          # mount
          {
            on = "M";
            run = "plugin mount";
          }
          # time travel
          {
            on = ["z" "h"];
            run = "plugin time-travel --args=prev";
            desc = "Go to previous snapshot";
          }
          {
            on = ["z" "l"];
            run = "plugin time-travel --args=next";
            desc = "Go to next snapshot";
          }
          {
            on = ["z" "e"];
            run = "plugin time-travel --args=exit";
            desc = "Exit time travel";
          }
        ];
        tasks.prepend_keymap = [
          {
            on = layout.up;
            run = "arrow -1";
          }
          {
            on = layout.down;
            run = "arrow 1";
          }
        ];
        select.prepend_keymap = [
          {
            on = layout.up;
            run = "arrow -1";
          }
          {
            on = layout.down;
            run = "arrow 1";
          }
          {
            on = layout.Up;
            run = "arrow -5";
          }
          {
            on = layout.Down;
            run = "arrow 5";
          }
        ];
        input.prepend_keymap = [
          {
            on = layout.insert;
            run = "insert";
          }

          # Navigation
          {
            on = layout.left;
            run = "move -1";
          }
          {
            on = layout.right;
            run = "move 1";
          }

          {
            on = layout.Left;
            run = "move -999";
          }
          {
            on = layout.Right;
            run = "move 999";
          }

          {
            on = layout.end;
            run = "forward --end-of-word";
          }
        ];
        help.prepend_keymap = [
          # Navigation
          {
            on = layout.up;
            run = "arrow -1";
          }
          {
            on = layout.down;
            run = "arrow 1";
          }

          {
            on = layout.Up;
            run = "arrow -5";
          }
          {
            on = layout.Down;
            run = "arrow 5";
          }
        ];
        completion.prepend_keymap = [
          {
            on = "<C-u>";
            run = "arrow -1";
          }
          {
            on = "<C-d>";
            run = "arrow 1";
          }
        ];
      };
    };

    home.persistence."/persist${config.home.homeDirectory}".directories = [
      ".local/state/yazi"
    ];
  };
}
