{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe getExe';
  inherit (lib.my) runOnce;
  hyprshot' = getExe' pkgs.hyprshot "hyprshot";
  satty' = getExe pkgs.satty;
  enable = config.my.desktop.shots == "hyprshot";
in {
  config = mkIf enable {
    home.packages = with pkgs; [
      hyprshot # screenshot grabber
    ];

    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          # region
          ", Print, exec, ${runOnce hyprshot'} --mode region --raw | ${runOnce satty'} --filename -"
          "$mod, K, exec, ${runOnce hyprshot'} --mode region --raw | ${runOnce satty'} --filename -"

          # current window
          "SHIFT, Print, exec, ${runOnce hyprshot'} --mode window --raw | ${runOnce satty'} --filename -"
          "$mod SHIFT, K, exec, ${runOnce hyprshot'} --mode window --raw | ${runOnce satty'} --filename -"

          # current screen
          "CTRL, Print, exec, ${runOnce hyprshot'} --mode output --raw | ${runOnce satty'} --filename -"
          "$mod CTRL, K, exec, ${runOnce hyprshot'} --mode output --raw | ${runOnce satty'} --filename -"
        ];
      };
    };
  };
}
