{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.direnv;
in {
  options.my.direnv = {
    enable = mkEnableOption "direnv" // {default = true;};
  };
  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        config.global = {hide_env_diff = true;};
      };
    };
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".local/share/direnv/allow"];
    };
  };
}
