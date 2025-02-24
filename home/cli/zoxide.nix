{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf types mkOption;
  cfg = config.my.zoxide;
in {
  options.my.zoxide = {
    enable = mkOption {
      default = true;
      type = types.bool;
      description = "Enable zoxide";
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide = {enable = true;};
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".local/share/zoxide"];
    };
  };
}
