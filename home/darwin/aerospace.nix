{config, mylib, ...}: {
  home.file.".aerospace.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    (mylib.relativeToConfig "aerospace.toml");
}