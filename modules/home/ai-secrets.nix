# FIXME: This is a temporary solution to get secrets into the home-manager
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.my) home name;
  userGroup = lib.my.ldTernary pkgs "users" "admin";
  user_readable = {
    symlink = false;
    owner = name;
    mode = "0400";
    group = userGroup;
  };
  cfg = config.hm.my.neovim.lazyvim;
  inherit (lib) mkIf mkMerge;
in {
  config = mkMerge [
    (mkIf cfg.copilot.enable {
      age.secrets.github-copilot =
        {
          rekeyFile = ./secrets/github-copilot.age;
          path = "${home}/.config/github-copilot/apps.json";
        }
        // user_readable;
    })
    (mkIf cfg.supermaven.enable {
      age.secrets.supermaven =
        {
          rekeyFile = ./secrets/supermaven.age;
          path = "${home}/.supermaven/config.json";
        }
        // user_readable;
    })

    (mkIf cfg.codeium.enable {
      age.secrets.codeium =
        {
          rekeyFile = ./secrets/codeium.age;
          path = "${home}/.cache/nvim/codeium/config.json";
        }
        // user_readable;
    })
  ];
}
