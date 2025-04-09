{lib, ...}: let
  inherit (lib) mkEnableOption;
  inherit (lib.my) scanPaths;
in {
  imports = scanPaths ./.;

  options.my.services.proxy = {
    enable = mkEnableOption "Enable the proxy service.";
  };
}
