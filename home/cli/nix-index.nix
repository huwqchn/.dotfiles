{
  nix-index-database,
  config,
  lib,
  ...
}:
{
  imports = [
    nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}
  ];
}
// lib.my.mkEnableModule config "nix-index" {
  programs.nix-index = {enable = true;};
}
