{
  config,
  lib,
  ...
}: let
  user_readable = {
    symlink = false;
    owner = config.my.name;
    mode = "0600";
  };
  cfg = config.hm.my.atuin;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    age.secrets = {
      atuin-key =
        {
          rekeyFile = ./secrets/atuin-key.age;
          path = "${config.my.home}/.local/share/atuin/key";
        }
        // user_readable;
    };
  };
}
