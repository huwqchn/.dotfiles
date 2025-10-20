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
  secretPath = config.sops.secrets.google_cloud_project.path;
  tokenExportShell = ''
    if [ -f ${secretPath} ]; then
      export GOOGLE_CLOUD_PROJECT="$(${cat'} ${secretPath})"
    fi
  '';
in {
  options.my.gemini-cli = {
    enable = mkEnableOption "gemini-cli";
  };

  config = mkIf cfg.enable {
    programs = {
      bash.initExtra = tokenExportShell;
      fish.shellInit = ''
        if test -f ${secretPath}
          set -x GOOGLE_CLOUD_PROJECT (${cat'} ${secretPath})
        end
      '';
      zsh.initContent = tokenExportShell;
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
