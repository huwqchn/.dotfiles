{
  config,
  lib,
  ...
}: let
  shellAliases = {
    "gemini" = "gemini-cli";
  };
  cfg = config.my.gemini-cli;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.gemini-cli = {
    enable = mkEnableOption "gemini-cli";
  };

  config = mkIf cfg.enable {
    programs.gemini-cli = {
      enable = true;
    };

    home = {
      inherit shellAliases;

      persistence."/persist${config.home.homeDirectory}".directories = [
        ".gemini"
      ];
    };
  };
}
