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
  cfg = config.my.rime;
in {
  options.my.rime = {
    enable = mkEnableOption "rime";

    dir = mkOption {
      type = types.str;
      default =
        {
          # /Library/Input\ Methods/Squirrel.app/Contents/SharedSupport
          darwin = "Library/Rime";
          linux = ".local/share/fcitx5/rime";
        }
        .${pkgs.stdenv.hostPlatform.parsed.kernel.name};
    };

    deploy = mkOption {
      type = types.str;
      default =
        {
          darwin = "'/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel' --reload";
          linux = "fcitx-remote -r";
        }
        .${pkgs.stdenv.hostPlatform.parsed.kernel.name};
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
