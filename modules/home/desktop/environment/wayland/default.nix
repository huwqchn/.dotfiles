{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my) desktop;
  isWayland = desktop.type == "wayland";
  enable = desktop.enable && isWayland;
in {
  imports = lib.my.scanPaths ./.;

  config = mkIf enable {
    home.packages = with pkgs; [
      grim
      slurp
      tesseract5
      # use more uwsm wrappers
      uwsm
      playerctl
      avizo
      wireplumber
      brillo
      brightnessctl
      wl-clip-persist
      wl-clipboard-rs
      wl-screenrec
      wlr-randr
      waypaper # GUI for wallpaper engine
    ];
  };
}
