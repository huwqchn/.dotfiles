{
  myvars,
  wallpapers,
  ...
}: let
  wallPath = "${wallpapers}/${myvars.userWall}";
in {
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [wallPath];
      wallpaper = [", ${wallPath}"];
    };
  };
}
