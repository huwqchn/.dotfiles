{
  lib,
  pkgs,
  ...
}: {
  imports = lib.my.scanPaths ./.;
  # use gowall to generate colorscheme
  home.packages = with pkgs; [
    gowall
  ];
}
