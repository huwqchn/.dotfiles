{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.my.desktop.apps.vlc;
  inherit (config.home) homeDirectory;
in {
  options.my.desktop.apps.vlc = {
    enable =
      mkEnableOption "VLC"
      // {
        default = config.my.desktop.enable && pkgs.stdenv.isLinux;
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
