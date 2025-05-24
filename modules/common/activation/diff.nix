{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkEnableOption;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  nvd' = getExe pkgs.nvd;
  cfg = config.my.activation.diff;
in {
  options.my.activation.diff.enable =
    mkEnableOption "Enable a system diff"
    // {
      default = true;
    };

  # if the system supports dry activation, this means that we can compare
  # the current system with the one we are about to switch to
  # this can be useful to see what will change, and the clousure size
  config = mkIf cfg.enable (mkMerge [
    {
      system.activationScripts.diff = {
        text = ''
          if [[ -e /run/current-system ]]; then
            echo "=== diff to current-system ==="
            ${nvd'} --nix-bin-dir='${config.nix.package}/bin' diff /run/current-system "$systemConfig"
            echo "=== end of the system diff ==="
          fi
        '';
      };
    }

    (mkIf isLinux {
      system.activationScripts.diff.supportsDryActivation = true;
    })

    # (mkIf isDarwin {
    #   system.activationScripts.postActivation.text = mkAfter ''
    #     ${config.system.activationScripts.diff.text}
    #   '';
    # })
  ]);
}
