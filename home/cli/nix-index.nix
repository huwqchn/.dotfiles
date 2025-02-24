{
  nix-index-database,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf types mkOption;
  cfg = config.my.nix-index;
in {
  imports = [
    nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}
  ];

  options.my.nix-index = {
    enable = mkOption {
      default = true;
      type = types.bool;
      description = "Enable nix-index";
    };
  };

  config = mkIf cfg.enable {programs.nix-index = {enable = true;};};
}
