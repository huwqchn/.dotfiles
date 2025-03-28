{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.desktop.apps.warp;
  inherit (config.home) homeDirectory;
in {
  options.my.desktop.apps.warp = {
    enable =
      mkEnableOption "Cloudflare Warp"
      // {
        default = config.my.apps.enable && config.my.machine.type == "laptop";
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
