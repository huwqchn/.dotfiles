{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkMerge mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (config.my) desktop;
  cfg = config.my.themes.tokyonight;
in {
  config = mkMerge [
    (mkIf (cfg.enable && cfg.style == "day" && isLinux && desktop.enable) {
      # my.themes.wallpaper = pkgs.fetchurl {
      #   url = "https://github.com/huwqchn/wallpapers/blob/main/tokyonight/Anime_girl.jpg";
      #   sha256 = "0irzajb3fi0f7x8vd6h55dsplkyl95p0vr9sigmlk46y673j6ksr";
      # };
      my.themes.wallpaper = ./walls/Anime_girl.png;
    })
    (mkIf (cfg.enable && cfg.style == "moon" && isLinux && desktop.enable) {
      # my.themes.wallpaper = pkgs.fetchurl {
      #   url = "https://github.com/huwqchn/wallpapers/blob/main/tokyonight/Night_City_Street_Umbrella.jpg";
      #   sha256 = "19nmdw8jldkh5niav478qwzvsnvfr3id3a02r4lgvmmb94kqv9xw";
      # };
      my.themes.wallpaper = ./walls/Night_City_Street_Umbrella.jpg;
    })
    (mkIf (cfg.enable && cfg.style == "night" && isLinux && desktop.enable) {
      # my.themes.wallpaper = pkgs.fetchurl {
      #   url = "https://github.com/huwqchn/wallpapers/blob/main/tokyonight/tokyonight-kimoni-girl.png";
      #   sha256 = "1y3nlxm8if13ckc8z1vfwkhn66sqb2az33l0ai1v1xh96nlp8qfz";
      # };
      my.themes.wallpaper = ./walls/tokyonight-kimoni-girl.png;
    })
    (mkIf (cfg.enable && cfg.style == "storm" && isLinux && desktop.enable) {
      # my.themes.wallpaper = pkgs.fetchurl {
      #   url = "https://github.com/huwqchn/wallpapers/blob/main/tokyonight/cafe-at-night_4k.png";
      #   sha256 = "1d7bimqagd4bf33ijvigfai9v1vca6ycii5sb0v00apwgz9wcp93";
      # };
      my.themes.wallpaper = ./walls/cafe-at-night_4k.png;
    })
  ];
}
