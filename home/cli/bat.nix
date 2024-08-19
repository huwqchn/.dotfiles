{ pkgs-stable, ... }: let
  shellAliases = {
    "cat" = "bat";
  };
in {
  home.shellAliases = shellAliases;
  # a cat(1) clone with syntax highlighting and Git integration.
  programs.bat = {
    enable = true;
    config = {
      pager = "leff -FR";
    };
    extraPackages = with pkgs-stable.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
