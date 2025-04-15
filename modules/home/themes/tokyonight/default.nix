{
  lib,
  config,
  pkgs,
  ...
}: let
  src = pkgs.vimPlugins.tokyonight-nvim;
  inherit (lib.modules) mkIf mkMerge importTOML;
  inherit (lib.generators) toINIWithGlobalSection;
  inherit (builtins) readFile;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (config.my.themes) transparent;
  inherit (config.my.themes) pad;
  inherit (config.my.machine) isHidpi;
  dpi =
    if isHidpi
    then 192
    else 96;

  cfg = config.my.themes.tokyonight;
  themeName = "tokyonight_${cfg.style}";
in {
  imports = lib.my.scanPaths ./.;

  config = mkMerge [
    (mkIf cfg.enable {
      home.sessionVariables = {THEME = themeName;};
      services.dunst.settings = importTOML "${src}/extras/dunst/${themeName}.dunstrc";
      programs = {
        git = {
          includes = [{path = "${src}/extras/delta/${themeName}.gitconfig";}];
          delta.options.features = themeName;
        };
        bat = {
          config.theme = themeName;
          themes = {
            "${themeName}" = {
              inherit src;
              file = "extras/sublime/${themeName}.tmTheme";
            };
          };
        };
        fish.interactiveShellInit = readFile "${src}/extras/fish/${themeName}.fish";
        btop.settings = {
          color_theme = "tokyo-night";
          theme_background = transparent.enable; # make it transparent
        };
        kitty.extraConfig = ''
          include ${src}/extras/kitty/${themeName}.conf
        '';
        starship.settings = let
          pad_style = "fg:gray";
          left_pad = "[${pad.left}](${pad_style})";
          right_pad = "[${pad.right} ](${pad_style})";
          inherit (builtins) concatStringsSep;
        in {
          username = {
            style_user = "bold blue";
            style_root = "bold red";
          };
          hostname = {
            style = "bold blue";
          };
          git_branch = {
            format = concatStringsSep "" [
              left_pad
              "[$symbol $branch ]($style)(:$remote_branch)"
            ];
            style = "bg:gray fg:green";
          };
          git_status = {
            format = concatStringsSep "" [
              "[$all_status$ahead_behind]($style)"
              right_pad
            ];
            style = "bg:gray fg:red";
          };
          directory = {
            format = concatStringsSep "" [
              left_pad
              "[$read_only]($read_only_style)"
              "[$path]($style)"
              right_pad
            ];
            style = "bg:gray fg:fg";
            read_only_style = "bg:gray fg:red";
          };
          nix_shell = {
            style = "fg:bold blue bg:gray";
            format = concatStringsSep "" [
              left_pad
              "[$symbol(\($name\))]($style)"
              right_pad
            ];
          };
          direnv = {
            style = "fg:bold yellow bg:gray";
            format = concatStringsSep "" [
              left_pad
              "[$symbol$loaded/$allowed]($style)"
              right_pad
            ];
          };
          conda = {
            style = "fg:bold blue bg:gray";
            format = concatStringsSep "" [
              right_pad
              "[$symbol$environment ]($style)"
              right_pad
            ];
          };
          container = {
            style = "fg:bold red dimmed bg:gray";
            format = concatStringsSep "" [
              left_pad
              "[$symbol \[$name\]]($style)"
              right_pad
            ];
          };
          cmd_duration = {
            format = "[$duration ](fg:yellow)";
          };
          status = {
            format = "[$symbol]($style)";
            success_style = "bold green";
          };
        };
        tmux.plugins = with pkgs.tmuxPlugins; let
          bg =
            if transparent.enable
            then "bg=default"
            else "bg=$color_background";
          pad_style = fg: "#[fg=${fg},${bg}]";
          gray_pad_style = pad_style "$color_gray";
          blue_pad_style = pad_style "$color_blue";
          left_pad = "${gray_pad_style}${pad.left}";
          right_pad = "${gray_pad_style}${pad.right}";
          current_left_pad = "${blue_pad_style}${pad.left}";
          current_right_pad = "${blue_pad_style}${pad.right}";
        in [
          {
            plugin = mode-indicator;
            extraConfig = lib.mkAfter ''
              #################################### PLUGINS ###################################

              set -g @mode_indicator_prefix_prompt " WAIT"
              set -g @mode_indicator_prefix_mode_style fg=$color_yellow,bg=$color_gray,bold
              set -g @mode_indicator_copy_prompt " COPY"
              set -g @mode_indicator_copy_mode_style fg=$color_green,bg=$color_gray,bold
              set -g @mode_indicator_sync_prompt " SYNC"
              set -g @mode_indicator_sync_mode_style fg=$color_red,bg=$color_gray,bold
              set -g @mode_indicator_empty_prompt " TMUX"
              set -g @mode_indicator_empty_mode_style fg=$color_blue,bg=$color_gray,bold

              #################################### OPTIONS ###################################

              set -g status on
              set -g status-justify centre
              set -g status-position top
              set -g status-left-length 90
              set -g status-right-length 90
              set -g status-style ${bg}
              setw -g window-status-separator " "

              # set -g window-style ""
              # set -g window-active-style ""

              # Note: default window-status-activity-style is 'reverse'
              setw -g window-status-activity-style none
              setw -g window-status-bell-style none

              set -g message-style bg=$color_blue,fg=$color_background
              set -g message-command-style bg=$color_background,fg=$color_foreground
              set-window-option -g mode-style bg=$color_gray,fg=$color_green

              set -g pane-border-style fg=$color_background
              set -g pane-active-border-style fg=$color_blue

              ##################################### FORMAT ###################################
              set -g status-left "${left_pad}#{tmux_mode_indicator}${right_pad}"
              set -g status-right "${left_pad}#[fg=$color_cyan,bg=$color_gray] #S${right_pad} ${left_pad}#[fg=$color_foreground,bg=$color_gray] %H:%M${right_pad}"
              setw -g window-status-format "${left_pad}#{?window_activity_flag,#[fg=$color_yellow],#[fg=$color_foreground]}#[bg=$color_gray,italics]#I: #[noitalics]#W#{?window_last_flag,  ,}#{?window_activity_flag,  ,}#{?window_bell_flag, #[fg=$color_red]󰂞 ,}${right_pad}"
              setw -g window-status-current-format "${current_left_pad}#[fg=$color_background,bg=$color_blue,italics]#I: #[bg=$color_blue,noitalics,bold]#{?window_zoomed_flag,[#W],#W}${current_right_pad}"
            '';
          }
        ];
        yazi = {
          # plugins = {
          #   yatline = pkgs.pkgs.fetchFromGitHub {
          #     owner = "imsi32";
          #     repo = "yatline.yazi";
          #     rev = "93282055cfb4d74a9bc8e47cf2035ded9b3c5b00";
          #     hash = "sha256-1TodD0sIeb/Y24rJk7pd1IfqLmbsFzxWvV0RSfwabIA=";
          #   };
          #   yatline-tokyo-night = pkgs.pkgs.fetchFromGitHub {
          #     owner = "wekauwau";
          #     repo = "yatline-tokyo-night.yazi";
          #     rev = "5a8d026481e96ecec558c831028cc8d94c8ac3ae";
          #     hash = "sha256-op2Fs26cF++D/plf5WJH2CdaousrMgGdEfH0jlouwTk=";
          #   };
          # };
          # initLua = ''
          #   local tokyo_night_theme = require("yatline-tokyo-night"):setup("${cfg.style}") -- or moon/storm/day
          #   require("yatline"):setup(tokyo_night_theme)
          # '';
          theme = {
            "$scheme" = "https://yazi-rs.github.io/schemas/theme.json";
            flavor.use = themeName;
          };
        };
        # wezterm.extraConfig = ''
        #   -- config.color_scheme = "Tokyo Night Moon"
        #   config.color_scheme_dirs = { wezterm.config_dir .. "/wezterm/themes" }
        #   config.color_scheme = "${themeName}"
        #   wezterm.add_to_config_reload_watch_list(config.color_scheme_dirs[1] .. config.color_scheme .. ".toml")
        # '';
        alacritty.settings = {
          import = ["${src}/extras/alacritty/${themeName}.yml"];
        };
        zathura.extraConfig = "include ${src + "/extras/zathura/" + themeName + ".zathurarc"}";
        ghostty.settings.theme = "${src + "/extras/ghostty/" + themeName}";
        nixcord.config = {
          transparent = true;
          frameless = true;
          enabledThemes = [
            "tokyo-night.theme.css"
          ];
          themeLinks = [
            "https://raw.githubusercontent.com/Dyzean/Tokyo-Night/main/themes/tokyo-night.theme.css"
          ];
        };
        spicetify = let
          tokyonightTheme = pkgs.fetchFromGitHub {
            owner = "evening-hs";
            repo = "Spotify-Tokyo-Night-Theme";
            rev = "d88ca06eaeeb424d19e0d6f7f8e614e4bce962be";
            hash = "sha256-cLj9v8qtHsdV9FfzV2Qf4pWO8AOBXu51U/lUMvdEXAk=";
          };
        in {
          theme = {
            name = "Tokyo";
            src = tokyonightTheme;
            overwriteAssets = true;
          };
          colorScheme =
            if cfg.style == "night"
            then "Night"
            else if cfg.style == "storm"
            then "Storm"
            else if cfg.style == "day"
            then "Light"
            else "Night";
        };
      };
    })
    (mkIf (cfg.enable && config.programs.yazi.enable) {
      xdg.configFile."yazi/flavors/${themeName}.yazi/flavor.toml".source = "${src}/extras/yazi/${themeName}.toml";
    })
    (mkIf (cfg.enable && config.programs.wezterm.enable) {
      xdg.configFile."wezterm/theme.lua".text = ''
        local wezterm = require("wezterm")

        local M = {}

        ---@param config Config
        function M.setup(config)
          config.color_scheme_dirs = { "${src}/extras/wezterm" }
          config.color_scheme = "${themeName}"
          wezterm.add_to_config_reload_watch_list(config.color_scheme_dirs[1] .. config.color_scheme .. ".toml")
        end

        return M
      '';
    })
    (mkIf (cfg.enable && isLinux) {
      i18n.inputMethod.fcitx5.addons = with pkgs; [fcitx5-tokyonight];
      xdg.configFile."fcitx5/conf/classicui.conf" = {
        enable = config.i18n.inputMethod.enabled == "fcitx5";
        text = let
          shade =
            if cfg.style == "day"
            then "Day"
            else "Storm";
        in
          toINIWithGlobalSection {} {
            globalSection = {
              Theme = "Tokyonight-${shade}";
              DarkTHeme = "Tokyonight-${shade}";
            };
          };
      };

      # FIXME: please tweak this to tokyonight theme

      # If your themes for mouse cursor, icons or windows don't load correctly,
      # try setting them with home.pointerCursor and gtk.theme,
      # which enable a bunch of compatibility options that should make the themes load in all situations.

      # NOTE: cursor is managed by stylix
      # https://github.com/danth/stylix/blob/master/stylix/hm/cursor.nix
      # home.pointerCursor = {
      #   gtk.enable = true;
      #   x11.enable = true;
      #   package = pkgs.bibata-cursors;
      #   name = "Bibata-Modern-Ice";
      #   size = 24;
      # };

      # I cont't know this, it's conflick with gtk
      # dconf.settings."org/gnome/desktop/interface".font-name = "Cantarell";

      # set dpi for 4k monitor
      xresources.properties = {
        # dpi for Xorg.s font
        "Xft.dpi" = dpi;
        # or set a generic dpi
        "*.dpi" = dpi;

        # These might also be useful depending on your monitor and personal preferences.
        "Xft.autohint" = 0;
        "Xft.lcdfilter" = "lcddefault";
        "Xft.hintstyle" = "hintfull";
        "Xft.antialias" = 1;
        "Xft.rgba" = "rgb";
      };

      # gkt's theme settings, generate files:
      #   1. ~/.gtkrc-2.0
      #   2. ~/.config/gtk-3.0/settings.ini
      #   3. ~/.config/gtk-4.0/settings.ini
      gtk = {
        enable = true;

        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

        # NOTE: font can managed by stylix if autoEnable is true
        font = {
          name = "Cantarell";
          package = pkgs.cantarell-fonts;
          size = 11;
        };

        # NOTE: iconTheme is managed by stylix if autoEnable is true
        # https://github.com/danth/stylix/blob/master/stylix/hm/icon.nix
        # iconTheme = {
        #   name = "Papirus-Dark";
        #   package = pkgs.papirus-icon-theme;
        # };

        theme = {
          # I don't stylix manager this, using mkForce to override
          name = "Tokyonight-Dark-BL";
          package = pkgs.tokyonight-gtk-theme;
        };

        # NOTE: cursorTheme can managed by stylix if autoEnable is true
        cursorTheme = {
          name = "Bibata-Modern";
          package = pkgs.bibata-cursors;
          size = 0;
        };
      };

      # TODO: make qt theme tokyonight
      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style = {
          package = pkgs.catppuccin-kvantum;
          name = "Kvantum";
        };
      };

      # xdg.configFile = {
      #   "Kvantum/kvantum.kvconfig".text = ''
      #     [General]
      #     theme=GraphiteNordDark
      #   '';
      #
      #   "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
      # };
    })
  ];
}
