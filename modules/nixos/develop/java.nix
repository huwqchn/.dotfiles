# modules/dev/java.nix --- Poster child for carpal tunnel
#
# TODO
{
  lib,
  config,
  ...
}: let
  cfg = config.my.develop.java;
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.my.develop.java = {
    enable = mkEnableOption "java development environment";
    xdg.enable = mkEnableOption "java XDG environment variables";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      # TODO
    })

    (mkIf cfg.xdg.enable {
      environment.sessionVariables._JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"'';
    })
  ];
}
