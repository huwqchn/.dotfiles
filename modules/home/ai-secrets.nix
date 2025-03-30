{
  config,
  lib,
  ...
}: let
  inherit (config.my) home name;
  user_readable = {
    symlink = false;
    owner = config.my.name;
    mode = "0500";
  };
  cfg = config.hm.my.neovim.lazyvim;
  inherit (lib) mkIf mkMerge;
in {
  config = mkMerge [
    (mkIf cfg.copilot.enable {
      age.secrets = {
        github-copilot =
          {
            rekeyFile = ./secrets/github-copilot.age;
            path = "${config.my.home}/.config/github-copilot/apps.json";
          }
          // user_readable;
      };
    })
    (mkIf cfg.supermaven.enable {
      age.secrets = {
        supermaven =
          {
            rekeyFile = ./secrets/supermaven.age;

            path = "${config.my.home}/.supermaven/config.json";
          }
          // user_readable;
      };
    })

    (mkIf cfg.codeium.enable {
      age.secrets = {
        codeium =
          {
            rekeyFile = ./secrets/codeium.age;

            path = "${config.my.home}/.cache/nvim/codeium/config.json";
          }
          // user_readable;
      };
    })
  ];
}
