{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.my.onedrive;
  isPersist = config.my.persist.eenable && cfg.enable;
in {
  options.my.onedrive = {
    enable = mkEnableOption "Enable OneDrive config";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      services.onedrive.enable = true;

      hm.xdg.configFile."onedrive/config".text = ''
        # try to download changes from onedrive every x seconds
        monitor_interval = "6"
        # fully scan data fro integrity every x attempt of download
        monitor_fullscan_frequency = "50"
        # minimum number of downloaded changes to trigger desktop notification
        min_notify_changes = "1"
        # ignore temporary stuff and weird obsidian file
        skip_file = "~*|.~*|*.tmp|.OBSIDIANTEST"
      '';
    })
    (mkIf isPersist {
      environment.persistence."/persist" = {
        users.${config.my.name}.directories = [
          "OneDrive"
          ".config/onedrive"
        ];
      };
    })
  ];
}
