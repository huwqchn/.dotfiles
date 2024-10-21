{
  myvars,
  wallpapers,
  ...
}: let
  wallPath = "${wallpapers}/${myvars.wallpaper}";
in {
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [wallPath];
      wallpaper = [", ${wallPath}"];
    };
  };
}
