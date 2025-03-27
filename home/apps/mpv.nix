{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.my.apps.mpv;
in {
  options.my.apps.mpv = {
    enable =
      mkEnableOption "support for mpv"
      // {
        default = config.my.apps.enable;
      };
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = pkgs.stdenv.hostPlatform.isLinux;
      package = pkgs.mpv;

      defaultProfiles = ["gpu-hq"];
      scripts = lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.mpvScripts.mpris];
    };

    services.plex-mpv-shim.enable = pkgs.stdenv.hostPlatform.isLinux;
  };
}
