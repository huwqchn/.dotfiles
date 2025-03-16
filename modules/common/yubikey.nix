{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  cfg = config.my.yubikey;
  homeDirectory = config.my.home;
  yubikey-up = let
    yubikeyIds = lib.concatStringsSep " " (
      lib.mapAttrsToList (name: id: "[${name}]=\"${builtins.toString id}\"") cfg.identifiers
    );
  in
    pkgs.writeShellApplication {
      name = "yubikey-up";
      runtimeInputs = builtins.attrValues {inherit (pkgs) gawk yubikey-manager;};
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        serial=$(ykman list | awk '{print $NF}')
        # If it got unplugged before we ran, just don't bother
        if [ -z "$serial" ]; then
          # FIXME(yubikey): Warn probably
          exit 0
        fi

        declare -A serials=(${yubikeyIds})

        key_name=""
        for key in "''${!serials[@]}"; do
          if [[ $serial == "''${serials[$key]}" ]]; then
            key_name="$key"
          fi
        done

        if [ -z "$key_name" ]; then
          echo WARNING: Unidentified yubikey with serial "$serial" . Won\'t link an SSH key.
          exit 0
        fi

        echo "Creating links to ${homeDirectory}/id_$key_name"
        ln -sf "${homeDirectory}/.ssh/id_$key_name" ${homeDirectory}/.ssh/id_yubikey
        ln -sf "${homeDirectory}/.ssh/id_$key_name.pub" ${homeDirectory}/.ssh/id_yubikey.pub
      '';
    };
  yubikey-down = pkgs.writeShellApplication {
    name = "yubikey-down";
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      rm ${homeDirectory}/.ssh/id_yubikey
      rm ${homeDirectory}/.ssh/id_yubikey.pub
    '';
  };
in {
  options.my.yubikey = {
    enable = mkEnableOption "yubikey support";

    identifiers = mkOption {
      default = {};
      type = lib.types.attrsOf lib.types.int;
      description = "Attrset of Yubikey serial numbers. NOTE: Yubico's 'Security Key' products do not use unique serial number therefore, the scripts in this module are unable to distinguish between multiple 'Security Key' devices and instead will detect a Security Key serial number as the string \"[FIDO]\". This means you can only use a single Security Key but can still mix it with YubiKey 4 and 5 devices.";
      example = lib.literalExample ''
        {
          foo = 12345678;
          bar = 87654321;
          baz = "[FIDO]";
        }
      '';
    };

    # type = mkOption {
    #   type = nullOr (enum [
    #     "NFC5"
    #     "nano"
    #   ]);
    #   default = null;
    #   description = "A list of devices to enable Yubikey support for";
    # };
  };

  config = mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    environment.systemPackages = lib.flatten [
      (builtins.attrValues {
        inherit
          (pkgs)
          yubikey-manager # cli-based authenticator tool. accessed via `ykman`

          pam_u2f # for yubikey with sudo
          ;
      })
      yubikey-up
      yubikey-down
    ];
    services.openssh.enable = true;
  };
}
