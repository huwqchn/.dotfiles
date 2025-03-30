# XDG stands for "Cross-Desktop Group", with X used to mean "cross".
# It's a bunch of specifications from freedesktop.org intended to standardize desktops and
# other GUI applications on various systems (primarily Unix-like) to be interoperable:
#   https://www.freedesktop.org/wiki/Specifications/
{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux;
  inherit (config) my;
  # define default applications for some url schemes.
  browser = [
    "x-scheme-handler/about" # open `about:` url with `browser`
    "x-scheme-handler/ftp" # open `ftp:` url with `browser`
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/unknown"
    "text/html"
    "text/xml"
    "application/xml"
    "application/xhtml+xml"
    "application/xhtml_xml"
    "application/rdf+xml"
    "application/rss+xml"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xht"
    "application/x-extension-xhtml"
  ];
  editor = [
    "application/json"
    "text/english"
    "text/plain"
    "text/x-makefile"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-csrc"
    "text/x-java"
    "text/x-moc"
    "text/x-pascal"
    "text/x-tcl"
    "text/x-tex"
    "application/x-shellscript"
    "text/x-c"
    "text/x-c++"
  ];
  media = [
    "video/*"
    "audio/*"
  ];

  images = ["image/*"];
  associations =
    (lib.genAttrs editor (_: [
      "${
        if my.editor == "helix"
        then "Helix"
        else my.editor
      }.desktop"
    ]))
    // (lib.genAttrs media (_: ["mpv.desktop"]))
    // (lib.genAttrs images (_: ["viewnior.desktop"]))
    // (lib.genAttrs browser (_: ["${my.browser}.desktop"]))
    // {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "x-scheme-handler/spotify" = ["spotify.desktop"];
      "x-scheme-handler/discord" = ["Discord.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop"];
      "inode/directory" = ["thunar.desktop"];
    };
in {
  # xdg.configFile."mimeapps.list".force = true;
  xdg = {
    enable = isLinux;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = mkIf isLinux {
      enable = true;
      createDirectories = true;

      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      desktop = "${config.home.homeDirectory}/desktop";
      videos = "${config.home.homeDirectory}/media/videos";
      music = "${config.home.homeDirectory}/media/music";
      pictures = "${config.home.homeDirectory}/media/pictures";
      publicShare = "${config.home.homeDirectory}/public/share";
      templates = "${config.home.homeDirectory}/public/templates";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_DEV_DIR = "${config.home.homeDirectory}/Dev";
      };
    };

    # manage $XDG_CONFIG_HOME/mimeapps.list
    # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
    #  echo $XDG_DATA_DIRS
    # the system-level desktop entries can be list by command:
    #   ls -l /run/current-system/sw/share/applications/
    # the user-level desktop entries can be list by command(user ryan):
    #  ls /etc/profiles/per-user/ryan/share/applications/
    mimeApps = {
      enable = isLinux;
      # let `xdg-open` to open the url with the correct application.
      defaultApplications = associations;
      associations.added = associations;
    };
  };
}
