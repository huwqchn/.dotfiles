{
  pkgs,
  config,
  wallpapers,
  myvars,
  ...
}:let
  package = pkgs.hyprpaper;
  wallPath = "${wallpapers}/${myvars.userWall}"
in {
  services.hyprpaper = {
    enable = true;
    inherit package;

    settings = {
      preload = [ wallPath ];
      wallpaper = [", ${wallPath}"];
    };
  };
}

