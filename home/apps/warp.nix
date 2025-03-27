{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.apps.warp;
  inherit (config.home) homeDirectory;
in {
  options.my.apps.warp = {
    enable =
      mkEnableOption "Cloudflare Warp"
      // {
        default = config.my.desktop.enable;
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [cloudflare-warp];

    systemd.user.services = {
      warp-taskbar = {
        Unit = {
          Description = "Cloudflare Warp taskbar";
          After = ["graphical-session.target"];
          PartOf = ["graphical-session.target"];
        };

        Service = {
          ExecStart = "${pkgs.cloudflare-warp}/bin/warp-taskbar";
          ExecStop = "pkill warp-taskbar";
        };

        Install.WantedBy = ["graphical-session.target"];
      };
    };

    home.persistence."/persist/${homeDirectory}" = {
      directories = [".local/share/warp"];
      allowOther = true;
    };
  };
}
