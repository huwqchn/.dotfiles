{ pkgs, ... }: {
  # a cat(1) clone with syntax highlighting and Git integration.
  programs.bat = {
    enable = true;
    config = {
      pager = "leff -FR";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
