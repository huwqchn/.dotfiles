{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe getExe';
  inherit (lib.my) runOnce;
  inherit (config.xdg.userDirs.extraConfig) XDG_SCREENSHOTS_DIR;
  hyprshot' = getExe' pkgs.hyprshot "hyprshot";
  wl-copy' = getExe' pkgs.wl-clipboard-rs "wl-copy";
  satty' = getExe pkgs.satty;
  enable = config.my.desktop.shots == "hyprshot";
in {
  config = mkIf enable {
    home = {
      file = {
        "${config.xdg.configHome}/satty/config.toml".text = ''
          [general]
          # Start Satty in fullscreen mode
          fullscreen = false
          # Exit directly after copy/save action
          early-exit = false
          # Select the tool on startup [possible values: pointer, crop, line, arrow, rectangle, text, marker, blur, brush]
          initial-tool = "pointer"
          # Configure the command to be called on copy, for example `wl-copy`
          copy-command = "${wl-copy'}"
          # Increase or decrease the size of the annotations
          annotation-size-factor = 1
          # Filename to use for saving action: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
          output-filename = "${XDG_SCREENSHOTS_DIR}/screenshot-%Y%m%d-%H%M%S.png"
          save-after-copy = false
          default-hide-toolbars = false
          # The primary highlighter: block, freehand
          primary-highlighter = "block"
          disable-notifications = false

          # Font to use for text annotations
          [font]
          family = "SFProDisplay Nerd Font"
          style = "Bold"
        '';
      };
      packages = with pkgs; [
        hyprshot # screenshot grabber
        satty # screenshot editor
      ];
    };

    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          ", Print, exec, ${runOnce hyprshot'} --mode output --raw | ${runOnce satty'} --filename -"
          "SHIFT, Print, exec, ${runOnce hyprshot'} --mode window --raw | ${runOnce satty'} --filename -"
          "ALT, Print, exec, ${runOnce hyprshot'} --mode region --raw | ${runOnce satty'} --filename -"
          "$mod, K, exec, ${runOnce hyprshot'} --mode output --raw | ${runOnce satty'} --filename -"
          "$mod SHIFT, K, exec, ${runOnce hyprshot'} --mode window --raw | ${runOnce satty'} --filename -"
          "$mod ALT, K, exec, ${runOnce hyprshot'} --mode region --raw | ${runOnce satty'} --filename -"
        ];
      };
    };
  };
}
