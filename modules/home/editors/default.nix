{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (config.my) editor;
in {
  imports = lib.my.scanPaths ./.;

  options.my.editor = mkOption {
    type = types.enum ["nvim" "helix"];
    default = "nvim";
    description = "The editor to use";
  };

  config = {
    home.sessionVariables = {
      EDITOR = "${editor}";
      VISUAL = "${editor}";
      GIT_EDITOR = "${editor}";
    };
  };
}
