{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.my) scanPaths;
in {
  imports = scanPaths ./.;

  options.my.services.proxy = {
    enable = mkEnableOption "Enable the proxy service.";
  };
}
