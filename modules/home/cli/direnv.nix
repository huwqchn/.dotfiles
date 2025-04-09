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
    silent = mkEnableOption "silent";
  };
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;

      inherit (cfg) silent;

      # faster, persistent implementation of use_nix and use_flake in
      # direnv based shells.
      nix-direnv.enable = true;

      config.global = {hide_env_diff = true;};
    };
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".local/share/direnv/allow"];
    };
  };
}
