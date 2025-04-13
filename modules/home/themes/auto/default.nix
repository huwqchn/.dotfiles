{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.types) enum;
  inherit (pkgs.stdenv) isLinux;
  cfg = config.my.themes.auto;
  wall = config.my.themes.wallpaper;
in {
  # this theme is based on your wallpaper
  options.my.themes.auto = {
    enable =
      mkEnableOption "Auto theme"
      // {
        default = config.my.themes.theme == "auto";
      };

    style = mkOption {
      type = enum ["dark" "light"];
      default = "moon";
      description = "The style of tokyonight";
    };
  };

  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  config = mkMerge [
    (mkIf cfg.enable {
      stylix = {
        enable = true;
        image = wall;
        polarity = cfg.style;
      };

      home.file.".config/gowall/config.yml".text = with config.lib.stylix.colors; ''
        themes:
          - name: "global"
            colors:
              - "#${base00}"
              - "#${base01}"
              - "#${base02}"
              - "#${base03}"
              - "#${base04}"
              - "#${base05}"
              - "#${base06}"
              - "#${base07}"
              - "#${base08}"
              - "#${base09}"
              - "#${base0A}"
              - "#${base0B}"
              - "#${base0C}"
              - "#${base0D}"
              - "#${base0E}"
              - "#${base0F}"
      '';
    })
    (mkIf (cfg.enable && isLinux) {
      # TODO:
    })
  ];
}
