{
  pkgs,
  config,
  hyprpaper,
  wallpapers,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = hyprpaper.packages.${pkgs.system}.default;

    settings = {
      preload = [ "${wallpapers.CyberPunk.png}" ];
      wallpaper = [", ${wallpapers.CyberPunk.png}"];
    };
  };
}
