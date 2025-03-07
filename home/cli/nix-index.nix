{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}
  ];
}
// lib.my.mkEnabledModule config "nix-index" {
  programs.nix-index = {enable = true;};
}
