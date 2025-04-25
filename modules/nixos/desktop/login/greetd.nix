{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.types) str;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (config.my) name desktop;
  inherit (desktop) environment;
  persist = config.my.persistence.enable;
  cfg = config.my.greetd;
in {
  options.my.greetd = {
    enable =
      mkEnableOption ''Whether to enable greetd as a display manager.''
      // {
        enable = desktop.login == "greetd";
      };
    login = mkOption {
      type = str;
      default = getExe (builtins.getAttr environment pkgs);
      description = ''
        The command to use for logging in. This is used by the
        `my.login` module to determine which command to run.
      '';
    };
    autologin =
      mkEnableOption ''
        Whether to enable passwordless login. This is generally useful on systems with
        FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
      ''
      // {
        default = persist;
      };
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      vt = 2;
      restart = !cfg.autologin;

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
            "--cmd ${cfg.login}" # login command
          ];
        };

        initial_session = mkIf cfg.autologin {
          user = name;
          command = cfg.login;
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
