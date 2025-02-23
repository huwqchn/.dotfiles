{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.conda;
in {
  options.my.conda = {enable = mkEnableOption "conda";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.conda];

    home.file.".condarc" = {
      text = ''
        channels:
          - conda-forge
          - defaults
        env_prompt: \'\'
        auto_activate_base: false
      '';
      executable = false;
    };

    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".conda"];
    };
  };
}
