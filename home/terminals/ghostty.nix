{
  config,
  mylib,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  xdg.configFile.ghostty.source = mkOutOfStoreSymlink (mylib.relativeToConfig "ghostty");
}
