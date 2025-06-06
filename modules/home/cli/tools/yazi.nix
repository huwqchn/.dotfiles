{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.yazi;
in {
  options.my.yazi = {
    enable = mkEnableOption "yazi";
  };

  config = mkIf cfg.enable {
    # terminal file manager
    programs.yazi = {
      enable = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      shellWrapperName = "y";
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      # enableNushellIntegration = true;
      plugins = {
        inherit (pkgs.yaziPlugins) starship;
        inherit (pkgs.yaziPlugins) sudo;
        inherit (pkgs.yaziPlugins) smart-enter;
        inherit (pkgs.yaziPlugins) smart-filter;
        inherit (pkgs.yaziPlugins) time-travel;
        inherit (pkgs.yaziPlugins) mount;
        inherit (pkgs.yaziPlugins) git;
        inherit (pkgs.yaziPlugins) chmod;
        inherit (pkgs.yaziPlugins) no-status;
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
        manager.prepend_keymap = [
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
            on = "i";
            run = "arrow -1";
          }
          {
            on = "e";
            run = "arrow 1";
          }
          {
            on = "n";
            run = "leave";
          }
          {
            on = "o";
            run = "plugin smart-enter";
          }

          {
            on = "N";
            run = "back";
          }
          {
            on = "O";
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
            on = "h";
            run = "hidden toggle";
          }

          # Operation
          {
            on = "l";
            run = "link";
          }
          {
            on = "L";
            run = "link --relative";
          }

          # Find
          {
            on = "k";
            run = "find_arrow";
          }
          {
            on = "K";
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
            on = "i";
            run = "arrow -1";
          }
          {
            on = "e";
            run = "arrow 1";
          }
        ];
        select.prepend_keymap = [
          {
            on = "i";
            run = "arrow -1";
          }
          {
            on = "e";
            run = "arrow 1";
          }
          {
            on = "I";
            run = "arrow -5";
          }
          {
            on = "E";
            run = "arrow 5";
          }
        ];
        input.prepend_keymap = [
          {
            on = "h";
            run = "insert";
          }

          # Navigation
          {
            on = "n";
            run = "move -1";
          }
          {
            on = "o";
            run = "move 1";
          }

          {
            on = "N";
            run = "move -999";
          }
          {
            on = "O";
            run = "move 999";
          }

          {
            on = "j";
            run = "forward --end-of-word";
          }
        ];
        help.prepend_keymap = [
          # Navigation
          {
            on = "i";
            run = "arrow -1";
          }
          {
            on = "e";
            run = "arrow 1";
          }

          {
            on = "I";
            run = "arrow -5";
          }
          {
            on = "E";
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
