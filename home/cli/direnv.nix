{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf types mkOption;
  cfg = config.my.direnv;
in {
  options.my.direnv = {
    enable = mkOption {
      default = true;
      type = types.bool;
      description = "Enable direnv";
    };
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
