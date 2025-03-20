{
  config,
  lib,
  ...
}: let
  user_readable = {
    symlink = false;
    owner = config.my.name;
    mode = "0500";
  };
  cfg = config.hm.my.neovim.lazyvim;
in {
  config = lib.mkMerge [
    (
      lib.mkIf cfg.copilot.enable {
        age.secrets = {
          github-copilot =
            {
              rekeyFile = ./secrets/github-copilot.age;
              path = "${config.my.home}/.config/github-copilot/apps.json";
            }
            // user_readable;
        };
      }
    )
    (
      lib.mkIf cfg.supermaven.enable {
        age.secrets = {
          supermaven =
            {
              rekeyFile = ./secrets/supermaven.age;
              path = "${config.my.home}/.supermaven/config.json";
            }
            // user_readable;
        };
      }
    )
    (
      lib.mkIf cfg.codeium.enable {
        age.secrets = {
          codeium =
            {
              rekeyFile = ./secrets/codeium.age;
              path = "${config.my.home}/.cache/nvim/codeium/config.json";
            }
            // user_readable;
        };
      }
    )
  ];
}
