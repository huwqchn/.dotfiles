{
  self,
  lib,
  inputs,
  ...
}: {
  flake = lib.my.mkHosts ../hosts (inputs // {inherit lib self;});
}
