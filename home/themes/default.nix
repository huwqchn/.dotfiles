{ lib, mylib, myvars, ... }: let
  userTheme = lib.splitString "-" myvars.userTheme;
  majorTheme = lib.elemAt userTheme 0;

in {

  imports = [
    ./systemTheme.nix
    ./${majorTheme}
  ];
}
