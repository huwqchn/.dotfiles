{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.apps.discord;
  inherit (config.home) homeDirectory;
in {
  options.my.apps.discord = {
    enable =
      mkEnableOption "Discord"
      // {
        default = config.my.apps.enable;
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      vesktop
    ];

    home.persistence."/persist/${homeDirectory}" = {
      allowOther = true;
      directories = [
        {
          directory = ".config/discord";
          method = "symlink";
        }
        {
          directory = ".config/vesktop";
          method = "symlink";
        }
      ];
    };
  };
}
