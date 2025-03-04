{lib, ...}: {
  imports = (lib.my.scanPaths ./.) ++ [ ../common ];
}
