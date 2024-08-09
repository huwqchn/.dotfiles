{
  pkgs,
  config,
  ...
}:let
  package = pkgs.hyprpaper;
in {
  services.hyprpaper = {
    enable = true;
    inherit package;

    settings = {
      preload = [ "./tokyonight.png" ];
      wallpaper = [", ./tokyonight.png"];
    };
  };
}

