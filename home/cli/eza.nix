{
  config,
  lib,
  ...
}: let
  shellAliases = {"tree" = "eza --git --icons --tree";};
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.eza;
in {
  options.my.eza = {enable = mkEnableOption "eza";};
  config = mkIf cfg.enable {
    home = {inherit shellAliases;};
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      extraOptions = ["--group-directories-first"];
    };
  };
}
