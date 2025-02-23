{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.my.scanPaths ./.;

  options.my.security.enable = mkEnableOption "my security";
}
