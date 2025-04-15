{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum;
  inherit (lib.modules) mkMerge mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (config.my) desktop;
  cfg = config.my.themes.tokyonight;
in {
  options.my.themes.tokyonight = {
    enable =
      mkEnableOption "Tokyonight theme"
      // {
        default = config.my.themes.theme == "tokyonight";
      };

    style = mkOption {
      type = enum ["night" "storm" "day" "moon"];
      default = "moon";
      description = "The style of tokyonight";
    };
  };

  config = mkMerge [
    (mkIf (cfg.enable && cfg.style == "day") {
      my.themes.wallpaper = mkIf (isLinux && desktop.enable) "${inputs.wallpapers}/tokyonight/Anime_girl.jpg";
    })
    (mkIf (cfg.enable && cfg.style == "moon") {
      my.themes.wallpaper = mkIf (isLinux && desktop.enable) "${inputs.wallpapers}/tokyonight/Night_City_Street_Umbrella.jpg";
    })
    (mkIf (cfg.enable && cfg.style == "night") {
      my.themes.wallpaper = mkIf (isLinux && desktop.enable) "${inputs.wallpapers}/Tokyo_streets_night.jpg";
    })
    (mkIf (cfg.enable && cfg.style == "storm") {
      my.themes.wallpaper = mkIf (isLinux && desktop.enable) "${inputs.wallpapers}/your_name.jpg";
    })
  ];
}
