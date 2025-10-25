{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (config.home) homeDirectory;
  cfg = config.my.desktop.apps.cloudflare-warp;
in {
  options.my.desktop.apps.cloudflare-warp = {
    enable =
      mkEnableOption "Cloudflare Warp"
      // {
        default =
          config.my.desktop.enable
          && config.my.machine.type == "laptop"
          && pkgs.stdenv.hostPlatform.isLinux;
      };
  };

  config = mkIf cfg.enable {
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

    home = {
      packages = with pkgs; [cloudflare-warp];
      persistence."/persist${homeDirectory}" = {
        directories = [".local/share/warp"];
        allowOther = true;
      };
    };
  };
}
