{pkgs, ...}: {
  stylix = {
    cursor = {
      # package = pkgs.phinger-cursors;
      # name = "phinger-cursors-light";
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    targets = {
      # for hyprland wallpaper, maybe i also need swwww
      hyprpaper.enable = true;
    };
  };
}
