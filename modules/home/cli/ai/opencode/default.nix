{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.khanelinix.programs.terminal.tools.opencode;
in {
  imports = lib.my.scanPaths ./.;

  options.my.opencode = {
    enable = mkEnableOption "OpenCode configuration";
  };

  config = mkIf cfg.enable {
    programs.opencode = {
      enable = true;

      package = inputs.nix-ai-tools.packages.${pkgs.system}.opencode;

      settings = {
        theme = "opencode";
        model = "anthropic/claude-sonnet-4-20250514";
        autoshare = false;
        autoupdate = false;
      };

      inherit ((import (lib.getFile "modules/common/ai-tools") {inherit lib;}).claudeCode) agents;

      inherit ((import (lib.getFile "modules/common/ai-tools") {inherit lib;}).claudeCode) commands;

      rules = builtins.readFile (lib.getFile "modules/common/ai-tools/base.md");
    };

    home.persistence."/persist${config.home.homeDirectory}".directories = [
      ".config/opencode"
    ];
  };
}
