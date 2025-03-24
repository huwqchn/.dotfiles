{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.meta) getExe';
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.my.plymouth;
in
{
  options.my.plymouth.enable = mkEnableOption "plymouth boot splash" // {
    default = true;
  };

  config = mkIf cfg.enable {
    boot.plymouth.enable = true;

    # make plymouth work with sleep
    powerManagement = {
      powerDownCommands = "${getExe' pkgs.plymouth "plymouth"} --show-splash";
      resumeCommands = "${getExe' pkgs.plymouth "plymouth"} --quit";
    };
  };
}
