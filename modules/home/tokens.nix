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
in {
  config = lib.mkMerge [
    (
      lib.mkIf config.hm.my.neovim.lazyvim.copilot.enable {
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
      lib.mkIf config.hm.my.neovim.lazyvim.supermaven.enable {
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
      lib.mkIf config.hm.my.neovim.lazyvim.codeium.enable {
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
