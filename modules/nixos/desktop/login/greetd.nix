{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.options) mkEnableOption;
  inherit (config.my) name;
  inherit (config.my.desktop) autologin;
  inherit (config.my.commands) login;
  persist = config.my.persistence.enable;
  cfg = config.my.desktop.login;
in {
  options.my.desktop.autologin =
    mkEnableOption ''
      Whether to enable passwordless login. This is generally useful on systems with
      FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
    ''
    // {
      default = persist;
    };

  config = mkIf (cfg == "greetd") {
    services.greetd = {
      enable = true;
      vt = 2;
      restart = !autologin;

      settings = {
        default_session = {
          user = "greeter";
          command = concatStringsSep " " [
            (getExe pkgs.greetd.tuigreet)
            "--greeting 'Welcome to NixOS!'"
            "--theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red"
            "--time" # display time
            "--remember" # remember last logged-in username
            "--remember-user-session" # remember last logged-in session
            "--asterisks" # display asterisks when typing password
            "--cmd ${login}" # login command
          ];
        };

        initial_session = mkIf autologin {
          user = name;
          command = login;
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
