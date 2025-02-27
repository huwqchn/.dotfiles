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
      yazi.theme = {
        "$scheme" = "https://yazi-rs.github.io/schemas/theme.json";
        flavor.use = themeName;
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
      zathura.extraConfig = "include ${src + "/" + themeName + ".zathurarc"}";
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
