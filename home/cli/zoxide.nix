{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.zoxide;
in {
  options.my.zoxide = {
    enable = mkEnableOption "zoxide" // {default = true;};
  };

  config = mkIf cfg.enable {
    programs.zoxide = {enable = true;};
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".local/share/zoxide"];
    };
  };
}
