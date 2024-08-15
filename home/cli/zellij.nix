let
  shellAliases = {
    "zj" = "zellij";
  };
in {
  # only works in bash/zsh, not nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
  programs.zellij = {
    enable = true;
    #TODO: add custom settings
  };
}

