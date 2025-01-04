{
  config,
  pkgs,
  ...
}: let
  src = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "b0e7c7382a7e8f6456f2a95655983993ffda745e";
    hash = "sha256-Fxakkz4+BTbvDLjRggZUVVhVEbg1b/MuuIC1rGrCwVA=";
  };
  inherit (config.my) theme;
  themeName = builtins.replaceStrings ["-"] ["_"] theme;
in {
  home.sessionVariables = {
    MY_THEME = themeName;
  };
  imports = [
    ./${theme}.nix
  ];
  programs = {
    git = {
      includes = [
        {path = "${src}/extras/delta/${themeName}.gitconfig";}
      ];
      delta.options = {
        syntax-theme = themeName;
      };
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
      import = [
        "${src}/extras/alacritty/${themeName}.yml"
      ];
    };
    zathura.extraConfig = "include ${themeName}";
  };

  xdg.configFile = {
    "fish/themes".source = "${src}/extras/fish_themes";
    "yazi/flavors/${themeName}.yazi/flavor.toml".source = "${src}/extras/yazi/${themeName}.toml";
    "zathura/${themeName}.zathurarc".source = "${src}/extras/zathura/${themeName}.zathurarc";
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
}
