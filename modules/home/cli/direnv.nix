{
  config,
  lib,
  ...
}: let
  cfg = config.my.direnv;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.direnv = {
    enable = mkEnableOption "direnv";
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
