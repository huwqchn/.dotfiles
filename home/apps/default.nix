{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.my.scanPaths ./.;

  options.my.apps.enable = mkEnableOption "my apps";
}
