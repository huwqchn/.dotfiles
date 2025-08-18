{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe;
  curl' = getExe pkgs.curl;
in {
  imports = lib.my.scanPaths ./.;
  home.shellAliases = {
    weather = "${curl'} wttr.in";
  };
}
