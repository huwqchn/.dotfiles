{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
  inherit (config.my) editor;
in {
  imports = lib.my.scanPaths ./.;

  options.my.editor = mkOption {
    type = enum ["nvim" "helix" "vscode"];
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
