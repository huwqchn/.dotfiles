{
  config,
  lib,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  xdg.configFile.ghostty.source = mkOutOfStoreSymlink (lib.my.relativeToConfig "ghostty");
}
