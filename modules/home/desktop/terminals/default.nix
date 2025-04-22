{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) enum nullOr str;
  inherit (lib.meta) getExe;
  inherit (lib.my) withUWSM;
  isHpyrland = config.my.desktop.environment == "hyprland";
  cfg = config.my.terminal;
in {
  imports = lib.my.scanPaths ./.;
  options.my = {
    commands.terminal = mkOption {
      type = str;
      default =
        if isHpyrland
        then withUWSM pkgs cfg
        else getExe (builtins.getAttr cfg pkgs);
      description = ''
        The command to use for the terminal. This is used by the
        `my.terminal` module to determine which command to run.
      '';
    };
    terminal = mkOption {
      type = nullOr (enum [
        "wzeterm"
        "alacritty"
        "ghostty"
        "kitty"
      ]);
      default =
        if config.my.desktop.enable
        then "ghostty"
        else null;
      description = "The terminal to use";
    };
  };

  config = mkIf (cfg != null) {
    home.sessionVariables = {TERMINAL = "${cfg}";};
  };
}
