{nix-index-database, ...}: {
  imports = [
    nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}
  ];

  programs.nix-index = {
    enable = true;
  };
}
