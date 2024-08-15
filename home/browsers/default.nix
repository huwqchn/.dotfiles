{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox-wayland
    google-chrome
  ];
}
