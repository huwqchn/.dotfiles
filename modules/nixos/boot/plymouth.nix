{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe';
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption types;

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
      themePackage = [cfg.themesPackage];
      theme = cfg.themeName;
    };

    # make plymouth work with sleep
    powerManagement = {
      powerDownCommands = "${getExe' pkgs.plymouth "plymouth"} --show-splash";
      resumeCommands = "${getExe' pkgs.plymouth "plymouth"} --quit";
    };
  };
}
