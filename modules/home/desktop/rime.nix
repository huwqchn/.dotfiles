{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  inherit (config.my) desktop;
  cfg = desktop.rime;
  kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;
in {
  options.my.desktop.rime = {
    enable =
      mkEnableOption "rime"
      // {
        default = desktop.enableInputMethod;
      };

    dir = mkOption {
      type = types.str;
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
      type = types.str;
      default =
        {
          darwin = "'/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel' --reload";
          linux = "fcitx-remote -r";
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
