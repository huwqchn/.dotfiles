{lib, ...}: {
  system = "aarch64-darwin";

  modules = lib.scanPaths ./.;
}
