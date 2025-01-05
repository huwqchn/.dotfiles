{
  config,
  lib,
  ...
}: {
  home.file.".aerospace.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    (lib.my.relativeToConfig "aerospace.toml");
}
