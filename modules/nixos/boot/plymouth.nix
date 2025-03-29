{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe';
  inherit (lib) mkIf mkEnableOption mkOption types;

  cfg = config.my.boot.plymouth;
in {
  options.my.boot.plymouth = {
    enable =
      mkEnableOption "plymouth boot splash"
      // {
        default = true;
      };

    playFullAnimation = mkEnableOption "Wait for the boot animation to finish playing before opening login shell.";
    themesPackage = mkOption {
      default = pkgs.plymouth-themes.override {inherit (cfg) themeName;};
      type = types.package;
    };
    themeName = mkOption {
      type = types.str;
      default = "abstract_ring_alt";
    };
  };

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      themePackages = [cfg.themesPackage];
      theme = cfg.themeName;
    };

    # make plymouth work with sleep
    powerManagement = {
      powerDownCommands = "${getExe' pkgs.plymouth "plymouth"} --show-splash";
      resumeCommands = "${getExe' pkgs.plymouth "plymouth"} --quit";
    };

    systemd.services.plymouth-quit.serviceConfig.ExecStartPre =
      mkIf cfg.playFullAnimation "${pkgs.coreutils-full}/bin/sleep 5";
  };
}
