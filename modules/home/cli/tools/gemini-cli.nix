{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.gemini-cli;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe';
  cat' = getExe' pkgs.coreutils "cat";
in {
  options.my.gemini-cli = {
    enable = mkEnableOption "gemini-cli";
  };

  config = mkIf cfg.enable {
    programs.gemini-cli = {
      enable = true;
    };

    home = {
      persistence."/persist${config.home.homeDirectory}".directories = [
        ".gemini"
      ];
      sessionVariables = {
        GOOGLE_CLOUD_PROJECT = "$(${cat'} ${config.sops.secrets.google_cloud_project.path})";
      };
    };

    sops.secrets.google_cloud_project = {};
  };
}
