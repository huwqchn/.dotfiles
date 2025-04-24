{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) runOnce;
  grimblast' = runOnce pkgs "grimblast";
  satty' = runOnce pkgs "satty";
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  isWayland = config.my.desktop.type == "wayland" && isLinux;
  enable = config.my.desktop.shot == "grimblast" && isWayland;
in {
  config = mkIf enable {
    # packages = with pkgs; [
    #   grimblast # screenshot grabber
    # ];
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          # region
          ", Print, exec, ${grimblast'} --notify copysave area - | ${satty'} --filename -"
          "$mod, K, exec, ${grimblast'} --notify copysave area - | ${satty'} --filename -"

          # current window
          "SHIFT, Print, exec, ${grimblast'} --notify copysave active - | ${satty'} --filename -"
          "$mod SHIFT, K, exec, ${grimblast'} --notify copysave active - | ${satty'} --filename -"

          # current screen
          "CTRL, Print, exec, ${grimblast'} --notify --cursor copysave output - | ${satty'} --filename -"
          "$mod CTRL, K, exec, ${grimblast'} --notify --cursor copysave output - | ${satty'} --filename -"

          # all screens
          "ALT, Print, exec, ${grimblast'} --notify --cursor copysave screen - | ${satty'} --filename -"
          "$mod ALT, K, exec, ${grimblast'} --notify --cursor copysave screen - | ${satty'} --filename -"
        ];
        env = [
          # can fix high cpu loads on some machines
          "GRIMBLAST_HIDE_CURSOR,0"
          # See https://github.com/hyprwm/contrib/issues/142
          "GRIMBLAST_NO_CURSOR,0"
        ];
      };
    };
  };
}
