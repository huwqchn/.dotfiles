{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.my.scanPaths ./.;

  options.my.apps = {
    enable =
      mkEnableOption "my apps"
      // {
        default = config.my.desktop.enable;
      };
  };
}
