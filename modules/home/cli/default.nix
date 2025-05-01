{
  lib,
  pkgs,
  ...
}: {
  imports = lib.my.scanPaths ./.;
  home.packages = with pkgs; [
    typst
    typstyle
  ];
}
