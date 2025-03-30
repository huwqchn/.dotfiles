# FIXME: This is a temporary solution to get secrets into the home-manager
{
  config,
  lib,
  self,
  ...
}: let
  inherit (config.my) home name;
  user_readable = {
    symlink = false;
    owner = name;
    mode = "0600";
  };
  cfg = config.hm.my;
  inherit (lib) mkIf mkMerge;
in {
  config = mkMerge [
    (mkIf cfg.atuin.enable {
      age.secrets = {
        atuin-key =
          {
            rekeyFile = ./secrets/atuin-key.age;
            path = "${home}/.local/share/atuin/key";
          }
          // user_readable;
      };
    })
    (mkIf cfg.git.enable {
      age.secrets = {
        git-credentials =
          {
            rekeyFile = ./secrets/git-credentials.age;
            path = "${home}/.git-credentials";
          }
          // user_readable;
      };
    })
    (mkIf cfg.security.enable {
      age.secrets = {
        my-ssh-key =
          {
            rekeyFile = "${self}/secrets/${name}/ssh-key.age";
            path = "${home}/.ssh/johnson-hu-ssh-key";
          }
          // user_readable;
      };
    })
  ];
}
