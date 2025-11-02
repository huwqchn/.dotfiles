# modules/dev/r.nix --- https://r-project.org/
#
# R’s ecosystem delights me. CRAN is a museum and a playground at once.
# But system libs, fonts, and geo deps can be… spicy. Let’s make it sane.
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.develop.r;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkEnableOption;
in {
  options.my.develop.r = {
    enable = mkEnableOption "R development environment";
    xdg.enable = mkEnableOption "R XDG environment variables";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      # --- Packages ----------------------------------------------------------
      home.packages = with pkgs.rPackages; [
        pkgs.R
        pkgs.rstudio
        # publisher tools
        pkgs.pandoc
        pkgs.quarto
        # R Language Server and Development Tools
        languageserver
        styler
        testthat
        roxygen2

        # Data Processing and Analysis
        tidyverse
        gridExtra
        kableExtra
        validate

        # Visualization
        ggplot2
        plotly
        viridis
        corrplot
        ggcorrplot

        # Machine Learning
        ROCR
        ranger
        VIM
        caret
        randomForest
        nnet

        # Shiny Web Framework
        shiny
        shinythemes
        shinydashboard
        shinyjs
        shiny_telemetry
        shinyWidgets
        shinyBS

        # Optimization and Constraint Solving (Epic 2)
        GA
        igraph
        ompr
        ROI
        lpSolve
        optimx
        Pareto

        # Database Integration (Epic 2)
        DBI
        RSQLite
        # config

        # Enhanced Visualization (Epic 2)
        leaflet
        heatmaply

        # Testing and Quality Assurance
        covr
        lintr

        # Additional Utilities
        DT
        htmltools
        jsonlite
        yaml
        RPostgreSQL

        # publish
        rmarkdown
      ];

      # --- Aliases -----------------------------------------------------------
      home.shellAliases = {
        r = "R";
        rs = "Rscript";
        rgd = "R -q -e 'httpgd::hgd()'"; # quick plot server
      };
    })

    (mkIf cfg.xdg.enable {
      # --- XDG mapping -------------------------------------------------------
      # Environment wiring for interop (only when enabled)
      home.sessionVariables = {
        # Prefer a consistent CRAN mirror; override per-project if needed
        R_REPOS = "https://cran.r-project.org";
        # Where user-installed R libs would go (if you ever install in R)
        R_LIBS_USER = "$XDG_DATA_HOME/R/library";

        # Config files
        R_PROFILE_USER = "$XDG_CONFIG_HOME/R/Rprofile";
        R_ENVIRON_USER = "$XDG_CONFIG_HOME/R/Renviron";

        # History (R >= 4.4 honors R_HISTFILE)
        R_HISTFILE = "$XDG_STATE_HOME/R/history";

        # Open things sanely
        R_BROWSER = "xdg-open";
        R_PDFVIEWER = "xdg-open";
      };
    })
  ];
}
