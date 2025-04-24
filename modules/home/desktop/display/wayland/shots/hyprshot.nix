{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) runOnce;
  hyprshot' = runOnce pkgs "hyprshot";
  satty' = runOnce pkgs "satty";
  inherit (pkgs.stdenv.platform) isLinux;
  isWayland = config.my.desktop.type == "wayland" && isLinux;
  enable = config.my.desktop.shot == "hyprshot" && isWayland;
in {
  config = mkIf enable {
    home.packages = with pkgs; [
      hyprshot # screenshot grabber
    ];

    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          # region
          ", Print, exec, ${hyprshot'} --mode region --raw | ${satty'} --filename -"
          "$mod, K, exec, ${hyprshot'} --mode region --raw | ${satty'} --filename -"

          # current window
          "SHIFT, Print, exec, ${hyprshot'} --mode window --raw | ${satty'} --filename -"
          "$mod SHIFT, K, exec, ${hyprshot'} --mode window --raw | ${satty'} --filename -"

          # current screen
          "CTRL, Print, exec, ${hyprshot'} --mode output --raw | ${satty'} --filename -"
          "$mod CTRL, K, exec, ${hyprshot'} --mode output --raw | ${satty'} --filename -"
        ];
      };
    };
  };
}
