{
  lib,
  pkgs,
  config,
  system,
  ...
}: let
  inherit (lib) mkIf mkMerge mkEnableOption;
  isx86Linux = system == "x86_64-linux";
  cfg = config.my.video;
in {
  options.my.video = {
    enable = mkEnableOption "Does the device allow for graphical programs";

    benchmarking.enable = mkEnableOption "Enable benchmarking tools";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = isx86Linux pkgs;
      };
    }

    # benchmarking tools
    (mkIf cfg.benchmarking.enable {
      environment.systemPackages = [
        pkgs.mesa-demos
        pkgs.glmark2
      ];
    })
  ]);
}
