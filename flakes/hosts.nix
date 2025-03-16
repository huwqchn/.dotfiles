{
  self,
  inputs,
  lib,
  ...
}: let
  specialArgs = {inherit self inputs lib;};
in {flake = lib.my.mkHosts ../hosts specialArgs;}
