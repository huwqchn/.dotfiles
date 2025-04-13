{
  self,
  inputs,
  lib,
  withSystem,
  ...
}: let
  specialArgs = {inherit self inputs lib withSystem;};
  # TODO: homeManagerConfigurations
  # TODO: DroidConfigurations
  # TODO: raspberry-pi-nixConfigurations
in {flake = lib.my.mkHosts ../hosts specialArgs;}
