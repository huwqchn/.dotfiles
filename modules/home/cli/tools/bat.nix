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
  };
  extrasShellAliases = {
    "man" = "batman";
    # "diff" = "batdiff"
    "bgrep" = "batgrep";
  };
  cfg = config.my.bat;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) optionalAttrs;
in {
  options.my.bat = {
    enable = mkEnableOption "bat";
    extras.enable =
      mkEnableOption "bat extras"
      // {
        description = "Enable bat-extras utilities that currently pull in nokogiri via ronn";
      };
  };

  config = mkIf cfg.enable {
    # a cat(1) clone with syntax highlighting and Git integration.
    programs.bat = {
      enable = true;
      config = {pager = "less -RF";};
      extraPackages =
        if cfg.extras.enable
        then
          with pkgs.bat-extras; [
            batdiff
            batman
            batgrep
            batwatch
            batpipe
          ]
        else [];
    };

    home = {
      inherit sessionVariables;
      shellAliases =
        shellAliases
        // optionalAttrs cfg.extras.enable extrasShellAliases;

      file.".lesskey" = mkIf (config.my.keyboard.layout == "colemak") {
        text = ''
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

      persistence."/persist${config.home.homeDirectory}".directories = [
        ".cache/bat"
      ];
    };
  };
}
