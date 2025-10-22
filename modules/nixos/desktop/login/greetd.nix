{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;
  inherit (config.my) name desktop;
  inherit (desktop) autologin exec;
  cfg = config.my.desktop.login;
in {
  config = mkIf (cfg == "greetd") {
    services.greetd = {
      enable = true;
      restart = !autologin;

      settings = {
        default_session = {
          user = "greeter";
          command = concatStringsSep " " [
            (getExe pkgs.tuigreet)
            "--greeting 'Welcome to NixOS!'"
            "--theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red"
            "--time" # display time
            "--remember" # remember last logged-in username
            "--remember-user-session" # remember last logged-in session
            "--asterisks" # display asterisks when typing password
            "--cmd ${exec}" # login command
          ];
        };

        initial_session = mkIf autologin {
          user = name;
          command = exec;
        };
      };
    };

    # Extend systemd service
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      # Without this errors will spam on screen
      StandardError = "journal";
      # Without this bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
