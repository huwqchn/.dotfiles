{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.theme.tokyonight;
  themeName = "tokyonight_${cfg.style}";
in {
  imports = lib.my.scanPaths ./.;

  config = mkIf cfg.enable {
    home.sessionVariables = {THEME = themeName;};
  };
}
