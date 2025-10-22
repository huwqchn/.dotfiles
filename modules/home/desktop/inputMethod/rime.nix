{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (config.my) desktop;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  dir = "Library/Rime";
  cfg = desktop.rime;
  # version = "2025.04.06";
  # rime-ice = pkgs.fetchFromGitHub {
  #   owner = "iDvel";
  #   repo = "rime-ice";
  #   tag = version;
  #   hash = "sha256-s3r8cdEliiPnKWs64Wgi0rC9Ngl1mkIrLnr2tIcyXWw=";
  #   fetchSubmodules = false;
  # };
in {
  options.my.desktop.squirrel = {
    enable =
      mkEnableOption "squirrel"
      // {
        default = desktop.enable && isDarwin;
      };
  };

  config = mkIf (cfg.enable && isDarwin) {
    home.file = {
      ${dir} = {
        source = "${pkgs.rime-ice}/share/rime-data";
        recursive = true;
      };
      "${dir}/default.yaml".source = "${pkgs.rime-ice}/share/rime-data/rime_ice_suggestion.yaml";
      # FIXME: not working anyway
      # "${dir}/default.custom.yaml".text = with config.my.keyboard.keys; ''
      #   key_binder/bindings:
      #     - { when: has_menu, accept: Control+${h}, send: Left }
      #     - { when: has_menu, accept: Control+${j}, send: Page_Down }
      #     - { when: has_menu, accept: Control+${k}, send: Page_Up }
      #     - { when: has_menu, accept: Control+${l}, send: Right }
      # '';
    };

    home.activation.rimeDeploy = lib.hm.dag.entryAfter ["writeBoundary"] ''
      app="/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel"
      "$app" --build  >/dev/null 2>&1 || :
      "$app" --reload >/dev/null 2>&1 || :
    '';
  };
}
