{
  config,
  lib,
  ...
}: let
  cfg = config.my.security.auditd;
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) int str;
in {
  options.my.security.auditd = {
    enable =
      mkEnableOption "Enable auditd"
      // {
        default = config.my.security.enable;
      };
    autoPrune = {
      enable =
        mkEnableOption "Enable auto-pruning of audit logs"
        // {
          default = cfg.enable;
        };

      size = mkOption {
        type = int;
        default = 524288000; # ~500 megabytes
        description = "The maximum size of the audit log in bytes";
      };

      dates = mkOption {
        type = str;
        default = "daily";
        example = "weekly";
        description = "How often the audit log should be pruned";
      };
    };
  };

  config = mkIf cfg.enable {
    security = {
      # system audit
      auditd.enable = true;

      audit = {
        enable = true;
        backlogLimit = 8192;
        failureMode = "printk";
        rules = [
          "-a exit,always -F arch=b64 -F euid=0 -S execve"
          "-a exit,always -F arch=b32 -F euid=0 -S execve"
          "-a exit,always -F arch=b64 -F euid=0 -S execveat"
          "-a exit,always -F arch=b32 -F euid=0 -S execveat"

          # Protect logfile
          "-w /var/log/audit/ -k auditlog"

          # Log program executions
          "-a exit,always -F arch=b64 -S execve -F key=progexec"

          # Home path access/modification
          "-a always,exit -F arch=b64 -F dir=/home -F perm=war -F key=homeaccess"

          # Kexec attempts
          "-a always,exit -F arch=b64 -S kexec_load -F key=KEXEC"
          "-a always,exit -F arch=b32 -S sys_kexec_load -k KEXEC"

          # Unauthorized file access
          "-a always,exit -F arch=b64 -S open,creat -F exit=-EACCES -k access"
          "-a always,exit -F arch=b64 -S open,creat -F exit=-EPERM -k access"
          "-a always,exit -F arch=b32 -S open,creat -F exit=-EACCES -k access"
          "-a always,exit -F arch=b32 -S open,creat -F exit=-EPERM -k access"
          "-a always,exit -F arch=b64 -S openat -F exit=-EACCES -k access"
          "-a always,exit -F arch=b64 -S openat -F exit=-EPERM -k access"
          "-a always,exit -F arch=b32 -S openat -F exit=-EACCES -k access"
          "-a always,exit -F arch=b32 -S openat -F exit=-EPERM -k access"
          "-a always,exit -F arch=b64 -S open_by_handle_at -F exit=-EACCES -k access"
          "-a always,exit -F arch=b64 -S open_by_handle_at -F exit=-EPERM -k access"
          "-a always,exit -F arch=b32 -S open_by_handle_at -F exit=-EACCES -k access"
          "-a always,exit -F arch=b32 -S open_by_handle_at -F exit=-EPERM -k access"

          # Failed modification of important mountpoints or files
          "-a always,exit -F arch=b64 -S open -F dir=/etc -F success=0 -F key=unauthedfileaccess"
          "-a always,exit -F arch=b64 -S open -F dir=/bin -F success=0 -F key=unauthedfileaccess"
          "-a always,exit -F arch=b64 -S open -F dir=/var -F success=0 -F key=unauthedfileaccess"
          "-a always,exit -F arch=b64 -S open -F dir=/home -F success=0 -F key=unauthedfileaccess"
          "-a always,exit -F arch=b64 -S open -F dir=/srv -F success=0 -F key=unauthedfileaccess"
          "-a always,exit -F arch=b64 -S open -F dir=/boot -F success=0 -F key=unauthedfileaccess"
          "-a always,exit -F arch=b64 -S open -F dir=/nix -F success=0 -F key=unauthedfileaccess"

          # File deletions by system users
          "-a always,exit -F arch=b64 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=-1 -F key=delete"

          # Root command executions
          "-a always,exit -F arch=b64 -F euid=0 -F auid>=1000 -F auid!=-1 -S execve -F key=rootcmd"

          # Shared memory access
          "-a exit,never -F arch=b32 -F dir=/dev/shm -k sharedmemaccess"
          "-a exit,never -F arch=b64 -F dir=/dev/shm -k sharedmemaccess"
        ];
      };
    };

    # the audit log can grow quite large, so we can automatically prune it
    systemd = mkIf cfg.autoPrune.enable {
      # a systemd timer to clean /var/log/audit.log daily
      # this can probably be weekly, but daily means we get to clean it every 2-3 days instead of once a week
      timers."clean-audit-log" = {
        description = "Periodically clean audit log";
        wantedBy = ["timers.target"];
        timerConfig = {
          OnCalendar = cfg.autoPrune.dates;
          Persistent = true;
        };
      };

      # clean audit log if it's more than 524,288,000 bytes, which is roughly 500 megabytes
      # it can grow MASSIVE in size if left unchecked
      services."clean-audit-log" = {
        script = ''
          set -eu
          if [[ $(stat -c "%s" /var/log/audit/audit.log) -gt ${toString cfg.autoPrune.size} ]]; then
            echo "Clearing Audit Log";
            rm -rvf /var/log/audit/audit.log;
            echo "Done!"
          fi
        '';

        serviceConfig = {
          Type = "oneshot";
          User = "root";
        };
      };
    };
  };
}
