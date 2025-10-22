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
  # version = "2025.04.06";
  # rime-ice = pkgs.fetchFromGitHub {
  #   owner = "iDvel";
  #   repo = "rime-ice";
  #   tag = version;
  #   hash = "sha256-s3r8cdEliiPnKWs64Wgi0rC9Ngl1mkIrLnr2tIcyXWw=";
  #   fetchSubmodules = false;
  # };
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
    home.file = {
      ${cfg.dir} = {
        source = "${pkgs.rime-ice}/share/rime-data";
        recursive = true;
      };
      "${cfg.dir}/default.yaml".source = "${pkgs.rime-ice}/share/rime-data/rime_ice_suggestion.yaml";
      # FIXME: not working anyway
      # "${cfg.dir}/default.custom.yaml".text = with config.my.keyboard.keys; ''
      #   key_binder/bindings:
      #     - { when: has_menu, accept: Control+${h}, send: Left }
      #     - { when: has_menu, accept: Control+${j}, send: Page_Down }
      #     - { when: has_menu, accept: Control+${k}, send: Page_Up }
      #     - { when: has_menu, accept: Control+${l}, send: Right }
      # '';
    };

    home.activation.rimeDeploy = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -n "${cfg.deploy}" ]; then
        echo "home-manager: deploying Rime schema via '${cfg.deploy}'"
        if ! ${cfg.deploy}; then
          echo "home-manager: rime deploy command failed" >&2
        fi
      fi
    '';
  };
}
