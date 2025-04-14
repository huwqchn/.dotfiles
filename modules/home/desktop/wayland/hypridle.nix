{
  config,
  lib,
  pkgs,
  ...
}: let
  package = pkgs.hypridle;
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    # check if any player has statutes "Playing"
    ${lib.getExe pkgs.playerctl} -a status | ${
      lib.getExe pkgs.ripgrep
    } Playing -q
    # only suspend if nothing is playing
    if [ $? == 1 ]; then
      ${pkgs.system}/bin/systemctl suspend
    fi

  '';

  brillo = lib.getExe pkgs.brillo;

  hyprlock = lib.getExe config.programs.hyprlock.package;

  # timeout after which DPMS kicks in
  timeout = 300;

  cfg = config.my.desktop;
  inherit (lib.modules) mkIf;
in {
  config = mkIf (cfg.enable && cfg.wayland.enable) {
    services.hypridle = {
      enable = true;
      inherit package;

      settings = {
        general = {
          # avoid starting multiple hyprlock instances
          lock_cmd = "pidof ${hyprlock} || ${hyprlock}";

          # lock before suspend
          before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";

          # to avoid having to press a key twice to turn on the display
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = timeout - 10;
            # save the current brightness and dim the screen over a period of
            # 1 second
            on-timeout = "${brillo} -O; ${brillo} -u 1000000 -S 10";
            # brighten the screen over a period of 500ms to the saved value
            on-resume = "${brillo} -I -u 500000";
          }

          # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
          {
            timeout = 150;
            # turn off keyboard backlight.
            on-timeout = "brightnessctl -sd dell::kbd_backlight set 0";
            # turn on keyboard backlight.
            on-resume = "brightnessctl -rd dell::kbd_backlight";
          }
          {
            # 5min
            timeout = 300;
            # lock screen when timeout has passed
            on-timeout = "loginctl lock-session";
          }
          {
            inherit timeout;
            # screen off when timeout has passed
            on-timeout = "hyprctl dispatch dpms off";
            # screen on when activity is detected after timeout has fired.
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = timeout + 10;
            # suspend pc
            on-timeout = suspendScript.outPath;
          }
        ];
      };
    };
  };
}
