{
  self,
  inputs,
  lib,
  withSystem,
  ...
}: let
  specialArgs = {inherit self inputs lib withSystem;};
in {flake = lib.my.mkHosts ../hosts specialArgs;}
