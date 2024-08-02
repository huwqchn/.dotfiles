{
  pkgs,
  config,
  hyprpaper,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = hyprpaper.packages.${pkgs.system}.default;

    settings = {
      preload = ["${config.theme.wallpaper}"];
      wallpaper = [", ${config.theme.wallpaper}"];
    };
  };
}
