{
  config,
  pkgs,
  lib,
  ...
}: let
  sessionVariables = {PAGER = "less -RF";};
  shellAliases = {
    "cat" = "bat --paging=never";
    "less" = "bat --paging=always";
    "man" = "batman";
    # "diff" = "batdiff"
    "bgrep" = "batgrep";
  };
  cfg = config.my.bat;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.bat = {
    enable = mkEnableOption "bat";
  };
  config = mkIf cfg.enable {
    home = {
      inherit shellAliases sessionVariables;
      file.".lesskey".text = ''
        #command
        n left-scroll
        o right-scroll
        i back-line
        I back-line-force
        ^I back-line
        E forw-line-force
        k repeat-search
        \ek repeat-search-all
        K reverse-search
        \eK reverse-search-all
        c clear-search
      '';
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    programs.bat = {
      enable = true;
      config = {pager = "less -RF";};
      extraPackages = with pkgs.bat-extras; [
        # batdiff # TODO:: fails to compile, nixpkgs-stable can compile successfully, but I can't overlays it with nixpkgs-unstable
        batman
        batgrep
        batwatch
      ];
    };
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".cache/bat"];
    };
  };
}
