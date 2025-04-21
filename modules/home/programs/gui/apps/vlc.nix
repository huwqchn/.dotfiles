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
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in {
  options.my.desktop.apps.vlc = {
    enable =
      mkEnableOption "VLC"
      // {
        default = config.my.desktop.enable && isLinux;
      };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [vlc];

      persistence."/persist${homeDirectory}" = {
        allowOther = true;
        directories = [".config/vlc"];
      };
    };
  };
}
