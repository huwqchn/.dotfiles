{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.apps.vlc;
  inherit (config.home) homeDirectory;
in {
  options.my.apps.vlc = {
    enable =
      mkEnableOption "VLC"
      // {
        default = config.apps.enable;
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [vlc];

    home.persistence."/persist/${homeDirectory}" = {
      allowOther = true;
      directories = [".config/vlc"];
    };
  };
}
