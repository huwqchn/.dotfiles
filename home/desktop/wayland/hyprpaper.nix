let
  background = "~/.config/background";
in {
  services.hyprpaper = {
    enable = false;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [background];
      wallpaper = [", ${background}"];
    };
  };
}
