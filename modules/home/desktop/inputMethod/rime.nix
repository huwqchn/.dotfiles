{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) str;
  inherit (lib.meta) getExe';

  inherit (config.my) desktop;
  cfg = desktop.rime;
  kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;
  fcitx5-remote' = getExe' pkgs.fcitx5 "fcitx5-remote";
in {
  options.my.desktop.rime = {
    enable =
      mkEnableOption "rime"
      // {
        default = desktop.enable;
      };

    dir = mkOption {
      type = str;
      default =
        {
          # /Library/Input\ Methods/Squirrel.app/Contents/SharedSupport
          darwin = "Library/Rime";
          linux = ".local/share/fcitx5/rime";
        }
        .${
          kernelName
        };
    };

    deploy = mkOption {
      type = str;
      default =
        {
          darwin = "'/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel' --reload";
          linux = "${fcitx5-remote'} -r";
        }
        .${
          kernelName
        };
    };
  };

  config = mkIf cfg.enable {
    home.file.${cfg.dir} = {
      source = pkgs.rime-ice;
      recursive = true;
      onChange = cfg.deploy;
    };
  };
}
