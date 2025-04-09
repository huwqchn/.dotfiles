{
  config,
  lib,
  ...
}: let
  cfg = config.my.zoxide;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.zoxide = {
    enable = mkEnableOption "zoxide";
  };
  config = mkIf cfg.enable {
    programs.zoxide = {enable = true;};
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".local/share/zoxide"];
    };
  };
}
