{
  config,
  pkgs,
  firefox-addons,
  ...
}: let
  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "128.0";
    hash = "sha256-Xbe9gHO8Kf9C+QnWhZr21kl42rXUQzqSDIn99thO1kE=";
  };
  arc = pkgs.fetchFromGitHub {
    owner = "zayihu";
    repo = "Minimal-Arc";
    rev = "c528e3f35faaa3edb55eacbf63f4bb9f4db499fd";
    hash = "sha256-nS+eU+x+m2rnhk2Up5d1UwTr+9qfr3pEd3uS4ehuGv0=";
  };
in {
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.default = {
      id = 0;
      isDefault = true;

      extraConfig = builtins.concatStringsSep "\n" [
        (builtins.readFile "${betterfox}/Securefox.js")
        (builtins.readFile "${betterfox}/Fastfox.js")
        (builtins.readFile "${betterfox}/Peskyfox.js")
      ];

      userChrome = builtins.readFile "${arc}/chrome/userChrome.css";

      extensions = with firefox-addons.packages.${pkgs.system}; [
        # onepassword-password-manager # 1Password — Password Manager
        # ublock-origin
        browserpass

        sponsorblock
        return-youtube-dislikes

        enhanced-github
        refined-github
        github-file-icons
        reddit-enhancement-suite
        cookie-autodelete
        darkreader
        sidebery
      ];

      settings = {
        "browser.startup.homepage" = "about:home";
        "browser.aboutConfig.showWarning" = false;
        "browser.download.useDownloadDir" = false; # Don't ask where to save stuff
        "browser.download.panel.shown" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = false;
        # Catch fat fingered quits.
        "browser.sessionstore.warnOnQuit" = true;
        # Compact UI.
        "browser.uidensity" = 1;
        "browser.compactmode.show" = true;
        # Plain new tabs.
        "browser.newtabpage.enabled" = false;
        # Smaller tab widths.
        "browser.tabs.tabMinWidth" = 50;
        # Locale.
        "browser.search.region" = "CN";
        # Allow custom styling.
        "widget.content.allow-gtk-dark-theme" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        # Speed up scroll for Linux/Xorg.
        "mousewheel.min_line_scroll_amount" = 60;
        # HTTPs only.
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;

        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "privacy.clearOnShutdown.history" = false; # We want to save history on exit
        # Allow executing JS in the dev console
        "devtools.chrome.enabled" = true;
        # Disable browser crash reporting

        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
      };

      search = {
        force = true;
        default = "Google";
        privateDefault = "DuckDuckGo";
        order = [
          "Google"
          "DuckDuckGo"
          "Kagi"
          "Youtube"
          "NixOS Options"
          "Nix Packages"
          "GitHub"
          "HackerNews"
          "HomeManager"
        ];

        engines = {
          "Kagi" = {
            urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
            iconUpdateURL = "https://kagi.com/favicon.ico";
          };
          "Bing".metaData.hidden = true;
          "YouTube" = {
            iconUpdateURL = "https://youtube.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@yt"];
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Nix Packages" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "NixOS Options" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "GitHub" = {
            iconUpdateURL = "https://github.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];

            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "HomeManager" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@hm"];

            url = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "HackerNews" = {
            iconUpdateURL = "https://hn.algolia.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@hn"];

            url = [
              {
                template = "https://hn.algolia.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".mozilla"
      ".cache/mozilla/firefox"
    ];
  };
}
