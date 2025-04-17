{
  lib,
  config,
  ...
}: let
  cfg = config.my.services.onedrive;
  isPersist = config.my.machine.persist && cfg.enable;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
in {
  options.my.services.onedrive = {
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
      hm.home.persistence."/persist${config.my.home}" = {
        directories = [
          "OneDrive"
          ".config/onedrive"
        ];
      };
    })
  ];
}
