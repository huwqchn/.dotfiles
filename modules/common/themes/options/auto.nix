{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum;
in {
  # this theme is based on your wallpaper
  options.my.themes.auto = {
    enable =
      mkEnableOption "Auto theme"
      // {
        default = config.my.themes.theme == "auto";
      };

    style = mkOption {
      type = enum [
        "either"
        "light"
        "dark"
      ];
      default = "either";
      description = ''
        Use this option to force a light or dark theme.

        By default we will select whichever is ranked better by the genetic
        algorithm. This aims to get good contrast between the foreground and
        background, as well as some variety in the highlight colours.
      '';
    };
  };
}
