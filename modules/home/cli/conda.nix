{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.conda;
in {
  options.my.conda = {enable = mkEnableOption "conda";};

  config = mkIf cfg.enable {
    home = {
      packages = [pkgs.conda];

      file.".condarc" = {
        text = ''
          channels:
            - conda-forge
            - defaults
          env_prompt: \'\'
          auto_activate_base: false
        '';
        executable = false;
      };

      persistence."/persist/${config.home.homeDirectory}".directories = [
        ".conda"
      ];
    };
  };
}
