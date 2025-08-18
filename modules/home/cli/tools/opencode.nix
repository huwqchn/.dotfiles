{
  config,
  lib,
  ...
}: let
  cfg = config.my.opencode;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.opencode = {
    enable = mkEnableOption "opencode";
  };

  config = mkIf cfg.enable {
    programs.opencode = {
      enable = true;
    };

    home.persistence."/persist${config.home.homeDirectory}".directories = [
      ".config/opencode"
    ];
  };
}
