# modules/dev/node.nix --- https://nodejs.org/en/
#
# JS is one of those "when it's good, it's alright, when it's bad, it's a
# disaster" languages.
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.develop.node;
  nodePkg = pkgs.nodejs_latest;
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.my.develop.node = {
    enable = mkEnableOption "Node.js development environment";
    xdg.enable = mkEnableOption "Node.js XDG environment variables";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = [
        nodePkg
        pkgs.yarn
      ];

      # Run locally installed bin-script, e.g. n coffee file.coffee
      home.shellAliases = {
        n = "PATH=\"$(${nodePkg}/bin/npm bin):$PATH\"";
        ya = "yarn";
      };

      home.sessionVariables.PATH = ["$(${pkgs.yarn}/bin/yarn global bin)"];
    })

    (mkIf cfg.xdg.enable {
      # NPM refuses to adopt XDG conventions upstream, so I enforce it myself.
      home.sessionVariables = {
        NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/config";
        NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
        NPM_CONFIG_PREFIX = "$XDG_CACHE_HOME/npm";
        NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
        NODE_REPL_HISTORY = "$XDG_CACHE_HOME/node/repl_history";
      };

      home.file."npm/config".text = ''
        cache=''${XDG_CACHE_HOME}/npm
        prefix=''${XDG_DATA_HOME}/npm
        tmp=''${XDG_RUNTIME_DIR}/npm
      '';
    })
  ];
}
