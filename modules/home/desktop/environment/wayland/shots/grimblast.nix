{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.my) runOnce;
  grimblast' = getExe pkgs.grimblast;
  satty' = getExe pkgs.satty;
  enable = config.my.desktop.shots == "grimblast";
in {
  config = mkIf enable {
    packages = with pkgs; [
      grimblast # screenshot grabber
    ];
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          # region
          ", Print, exec, ${runOnce grimblast'} --notify copysave area - | ${runOnce satty'} --filename -"
          "$mod, K, exec, ${runOnce grimblast'} --notify copysave area - | ${runOnce satty'} --filename -"

          # current window
          "SHIFT, Print, exec, ${runOnce grimblast'} --notify copysave active - | ${runOnce satty'} --filename -"
          "$mod SHIFT, K, exec, ${runOnce grimblast'} --notify copysave active - | ${runOnce satty'} --filename -"

          # current screen
          "CTRL, Print, exec, ${runOnce grimblast'} --notify --cursor copysave output - | ${runOnce satty'} --filename -"
          "$mod CTRL, K, exec, ${runOnce grimblast'} --notify --cursor copysave output - | ${runOnce satty'} --filename -"

          # all screens
          "ALT, Print, exec, ${runOnce grimblast'} --notify --cursor copysave screen - | ${runOnce satty'} --filename -"
          "$mod ALT, K, exec, ${runOnce grimblast'} --notify --cursor copysave screen - | ${runOnce satty'} --filename -"
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
