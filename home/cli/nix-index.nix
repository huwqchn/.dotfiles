{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.my.nix-index;
  inherit (lib) mkEnableOption mkIf;
in {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    {programs.nix-index-database.comma.enable = true;}
  ];

  options.my.nix-index = {
    enable = mkEnableOption "nix-index";
  };

  config = mkIf cfg.enable {
    programs.nix-index = {enable = true;};
  };
}
