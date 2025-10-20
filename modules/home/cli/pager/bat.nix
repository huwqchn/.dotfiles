{
  config,
  pkgs,
  lib,
  ...
}: let
  sessionVariables = {
    PAGER = "less -RF";
    MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --plain --language=man'";
  };
  shellAliases = {
    cat = "bat --paging=never";
    less = "bat --paging=always";
    man = "batman";
    diff = "batdiff";
    bgrep = "batgrep";
  };
  cfg = config.my.bat;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe getExe';
  inherit (lib.strings) concatMapStrings;
in {
  options.my.bat = {
    enable = mkEnableOption "bat";
  };

  config = mkIf cfg.enable {
    # a cat(1) clone with syntax highlighting and Git integration.
    programs.bat = {
      enable = true;
      config = {pager = "less -RF";};
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
        batpipe
      ];
    };

    home = {
      inherit sessionVariables shellAliases;

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

    # Custom batpipe viewers
    xdg.configFile."batpipe/viewers.d/custom.sh".text = let
      makeViewer = {
        command,
        filetype,
        header ? "",
      }: let
        program = builtins.baseNameOf (builtins.head (lib.strings.splitString " " command));
      in
        #sh
        ''
          BATPIPE_VIEWERS+=("${program}")

          viewer_${program}_supports() {
            case "$1" in
              ${filetype}) return 0;;
            esac
            return 1
          }

          viewer_${program}_process() {
            ${header}
            ${command}
            return "$?"
          }
        '';
      batpipe_archive_header =
        # sh
        ''
          batpipe_header    "Viewing contents of archive: %{PATH}%s" "$1"
          batpipe_subheader "To view files within the archive, add the file path after the archive."
        '';
      batpipe_document_header =
        # sh
        ''
          batpipe_header "Viewing text of document: %{PATH}%s" "$1"
        '';
    in
      concatMapStrings makeViewer [
        {
          command = ''${getExe pkgs.python3Packages.docx2txt} "$1"'';
          filetype = "*.docx";
          header = batpipe_document_header;
        }
        {
          command = ''${getExe pkgs.glow} --style ${config.home.sessionVariables.GLAMOUR_STYLE} "$1"'';
          filetype = "*.md";
        }
        {
          command = ''${getExe pkgs.odt2txt} "$1"'';
          filetype = "*.odt";
          header = batpipe_document_header;
        }
        {
          command = ''${getExe' pkgs.pdfminer "pdf2txt"} "$1"'';
          filetype = "*.pdf";
          header = batpipe_document_header;
        }
        {
          command = ''${getExe pkgs.unrar} "$1"'';
          filetype = "*.rar";
          header = batpipe_archive_header;
        }
      ];
  };
}
