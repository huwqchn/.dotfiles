{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
  inherit (lib.meta) getExe;
  less' = getExe pkgs.less;
in {
  imports = lib.my.scanPaths ./.;
  options.my.pager = mkOption {
    type = str;
    default = "${less'} -FR";
    description = "The editor to use";
  };
}
