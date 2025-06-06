{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.strings) escapeShellArgs;
  inherit (lib.meta) getExe';
  inherit
    (lib.types)
    int
    str
    bool
    oneOf
    listOf
    attrsOf
    ;

  notify-send' = getExe' pkgs.libnotify "notify-send";

  cfg = config.my.security.clamav;
in {
  options.my.security.clamav = {
    enable =
      mkEnableOption "Enable ClamAV daemon."
      // {
        default = config.my.security.enable;
      };

    daemon = {
      settings = mkOption {
        type = attrsOf (oneOf [
          bool
          int
          str
          (listOf str)
        ]);
        default = {
          LogFile = "/var/log/clamd.log";
          LogTime = true;
          DetectPUA = true;
          VirusEvent = escapeShellArgs [
            "${notify-send'}"
            "--"
            "ClamAV Virus Scan"
            "Found virus: %v"
          ];
        };

        description = ''
          ClamAV configuration. Refer to <https://linux.die.net/man/5/clamd.conf>,
          for details on supported values.
        '';
      };
    };

    updater = {
      enable = mkEnableOption "ClamAV freshclam updater";

      frequency = mkOption {
        type = int;
        default = 12;
        description = ''
          Number of database checks per day.
        '';
      };

      interval = mkOption {
        type = str;
        default = "hourly";
        description = ''
          How often freshclam is invoked. See systemd.time(7) for more
          information about the format.
        '';
      };

      settings = mkOption {
        type = attrsOf (oneOf [
          bool
          int
          str
          (listOf str)
        ]);
        default = {};
        description = ''
          freshclam configuration. Refer to <https://linux.die.net/man/5/freshclam.conf>,
          for details on supported values.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.clamav = {
      daemon =
        {
          enable = true;
        }
        // cfg.daemon;
      updater =
        {
          enable = true;
        }
        // cfg.updater;
    };

    systemd = {
      tmpfiles.settings."10-clamav"."/var/lib/clamav".D = {
        mode = "755";
        user = "clamav";
        group = "clamav";
      };

      services = {
        clamav-daemon = {
          serviceConfig = {
            PrivateTmp = mkForce "no";
            PrivateNetwork = mkForce "no";
            Restart = "always";
          };

          unitConfig = {
            # only start clamav when required database files are present
            # especially useful if you are deploying headlessly and don't want a service fail instantly
            ConditionPathExistsGlob = [
              "/var/lib/clamav/main.{c[vl]d,inc}"
              "/var/lib/clamav/daily.{c[vl]d,inc}"
            ];
          };
        };

        clamav-init-database = {
          wantedBy = ["clamav-daemon.service"];
          before = ["clamav-daemon.service"];
          serviceConfig.ExecStart = "systemctl start clamav-freshclam";
          unitConfig = {
            # opposite condition of clamav-daemon: only run this service if
            # database files are not present in the database directory
            ConditionPathExistsGlob = [
              "!/var/lib/clamav/main.{c[vl]d,inc}"
              "!/var/lib/clamav/daily.{c[vl]d,inc}"
            ];
          };
        };

        clamav-freshclam = {
          wants = ["clamav-daemon.service"];
          serviceConfig = {
            ExecStart = let
              message = "Updating ClamAV database";
            in ''
              ${getExe' pkgs.coreutils "echo"} -en ${message}
            '';
            SuccessExitStatus = mkForce [
              11
              40
              50
              51
              52
              53
              54
              55
              56
              57
              58
              59
              60
              61
              62
            ];
          };
        };
      };

      timers.clamav-freshclam.timerConfig = {
        # the default is to run the timer hourly but we do not want our entire infra to be overloaded
        # trying to run clamscan at the same time. randomize the timer to something around an hour
        # so that the window is consistent, but the load is not
        RandomizedDelaySec = "60m";
        FixedRandomDelay = true;
        Persistent = true;
      };
    };
  };
}
