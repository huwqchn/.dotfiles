{
  lib,
  myvars,
  ...
}: let
  userTheme = lib.splitString "-" myvars.theme;
  majorTheme = lib.elemAt userTheme 0;
in {
  imports = [
    ./systemTheme.nix
    ./${majorTheme}
  ];
}
