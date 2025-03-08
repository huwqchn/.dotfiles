{
  self,
  inputs,
  inputs',
  lib,
  ...
}: let
  specialArgs = {inherit self inputs inputs' lib;};
in {flake = lib.my.mkHosts ../hosts specialArgs;}
