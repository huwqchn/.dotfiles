{
  nix-index-database,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.nix-index;
in {
  imports = [
    nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}
  ];

  options.my.nix-index = {
    enable = mkEnableOption "nix-index" // {default = true;};
  };

  config = mkIf cfg.enable {programs.nix-index = {enable = true;};};
}
