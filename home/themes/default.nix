{
  lib,
  myvars,
  wallpapers,
  ...
}: let
  userTheme = lib.splitString "-" myvars.theme;
  majorTheme = lib.elemAt userTheme 0;
  background = "${wallpapers}/${myvars.wallpaper}";
in {
  imports = [
    ./systemTheme.nix
    ./${majorTheme}
  ];
  # wallpaper
  home.file."Pictures/Wallpapers".source = wallpapers;
  home.activation.wallpaper = ''
    cp "${background}" ~/.config/background
    chmod 666 ~/.config/background
  '';
}
