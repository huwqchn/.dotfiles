{
  inputs,
  config,
  lib,
  pkgs,
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
      package = inputs.nix-ai-tools.packages.${pkgs.system}.opencode;
    };

    home.persistence."/persist${config.home.homeDirectory}".directories = [
      ".config/opencode"
    ];
  };
}
