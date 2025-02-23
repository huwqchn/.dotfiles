{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.zoxide;
in {
  options.my.zoxide = {enable = mkEnableOption "zoxide";};

  config = mkIf cfg.enable {
    programs.zoxide = {enable = true;};
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".local/share/zoxide"];
    };
  };
}
