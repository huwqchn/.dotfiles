{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.apps.obs;
  inherit (config.home) homeDirectory;
in {
  options.my.apps.obs = {
    enable =
      mkEnableOption "OBS"
      // {
        default = config.my.apps.enable;
      };
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-livesplit-one
        obs-pipewire-audio-capture
        input-overlay
      ];
    };

    home.persistence."/persist/${homeDirectory}" = {
      allowOther = true;
      directories = [
        {
          directory = ".config/obs-studio";
          method = "symlink";
        }
      ];
    };
  };
}
