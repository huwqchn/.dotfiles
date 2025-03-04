{
  config,
  lib,
  ...
}: let
  shellAliases = {"tree" = "eza --git --icons --tree";};
in
  lib.my.mkEnabledModule config "eza" {
    home = {inherit shellAliases;};
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      extraOptions = ["--group-directories-first"];
    };
  }
