{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  src = pkgs.vimPlugins.tokyonight-nvim;
  cfg = config.my.themes.tokyonight;
  themeName = "tokyonight_${cfg.style}";
in {
  config = mkIf cfg.enable {
    programs.yazi = {
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
    xdg.configFile = mkIf config.programs.yazi.enable {
      "yazi/flavors/${themeName}.yazi/flavor.toml".source = "${src}/extras/yazi/${themeName}.toml";
    };
  };
}
