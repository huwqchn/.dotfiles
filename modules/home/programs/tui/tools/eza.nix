{
  config,
  lib,
  ...
}: let
  shellAliases = {"tree" = "eza --git --icons --tree";};
  cfg = config.my.eza;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.eza = {
    enable = mkEnableOption "eza";
  };

  config = mkIf cfg.enable {
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      extraOptions = ["--group-directories-first"];
    };

    home = {
      inherit shellAliases;
    };
  };
}
