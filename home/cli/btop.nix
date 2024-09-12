let
  shellAliases = {
    "top" = "btop";
  };
in {
  home.shellAliases = shellAliases;
  programs.btop = {
    enable = true;
  };
}
