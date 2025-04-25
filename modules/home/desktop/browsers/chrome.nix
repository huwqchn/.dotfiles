{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop.apps.chrome;
in {
  options.my.desktop.apps.chrome = {
    enable =
      mkEnableOption "chrome"
      // {
        default = config.my.browser.name == "chrome";
      };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [google-chrome];

      persistence = {
        "/persist${config.home.homeDirectory}".directories = [".config/google-chrome"];
      };
    };
  };
}
