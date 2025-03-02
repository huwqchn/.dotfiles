{
  lib,
  config,
  pkgs,
  ...
}: let
  src = pkgs.vimPlugins.tokyonight-nvim;
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.my.tokyonight;
  themeName = "tokyonight_${cfg.style}";
in {
  options.my.tokyonight = {
    enable =
      mkEnableOption "Tokyonight theme"
      // {
        default = config.my.theme == "tokyonight";
      };

    style = mkOption {
      type = types.enum ["night" "storm" "day" "moon"];
      default = "moon";
      description = "The style of tokyonight";
    };
  };

  imports = lib.my.scanPaths ./.;

  config = mkIf cfg.enable {
    home.sessionVariables = {THEME = themeName;};
    programs = {
      git = {
        includes = [{path = "${src}/extras/delta/${themeName}.gitconfig";}];
        delta.options = {syntax-theme = themeName;};
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
      fish = {
        interactiveShellInit = ''
          fish_config theme choose ${themeName}
        '';
      };
      btop = {
        settings = {
          color_theme = "tokyo-night";
          theme_background = true; # make btop transparent
        };
      };
      kitty = {
        extraConfig = ''
          include ${src}/extras/kitty/${themeName}.conf
        '';
      };
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
    };

    xdg.configFile = {
      "fish/themes".source = "${src}/extras/fish_themes";
      "yazi/flavors/${themeName}.yazi/flavor.toml".source = "${src}/extras/yazi/${themeName}.toml";
      "wezterm/theme.lua".text = ''
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
    };
  };
}
