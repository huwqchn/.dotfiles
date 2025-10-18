{
  inputs,
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
  tokenExportsBash = ''
    if [ -f ${config.sops.secrets.google_cloud_project.path} ]; then
      GOOGLE_CLOUD_PROJECT="$(${cat'} ${config.sops.secrets.google_cloud_project.path})"
      export GOOGLE_CLOUD_PROJECT
    fi
  '';
  tokenExportsFish = ''
    if test -f ${config.sops.secrets.google_cloud_project.path}
      set -x GOOGLE_CLOUD_PROJECT (${cat'} ${config.sops.secrets.google_cloud_project.path})
    end
  '';
in {
  options.my.gemini-cli = {
    enable = mkEnableOption "gemini-cli";
  };

  config = mkIf cfg.enable {
    programs = {
      bash.initExtra = tokenExportsBash;
      fish.shellInit = tokenExportsFish;
      zsh.initContent = tokenExportsBash;
      gemini-cli = {
        enable = true;
        package = inputs.nix-ai-tools.packages.${pkgs.system}.gemini-cli;
      };
    };

    home = {
      persistence."/persist${config.home.homeDirectory}".directories = [
        ".gemini"
      ];
    };

    sops.secrets.google_cloud_project = {};
  };
}
