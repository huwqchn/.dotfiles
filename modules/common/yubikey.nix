{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.attrsets) optionalAttrs mapAttrsToList getBin;
  inherit (lib.lists) flatten;
  inherit (lib.types) attrsOf int literalExample;
  inherit (lib.strings) concatStringsSep;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  cfg = config.my.yubikey;
  homeDirectory = config.my.home;
  yubikey-up = let
    yubikeyIds = concatStringsSep " " (
      mapAttrsToList (name: id: "[${name}]=\"${builtins.toString id}\"") cfg.identifiers
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
    enable =
      mkEnableOption "yubikey support"
      // {
        default = true;
      };

    identifiers = mkOption {
      default = {
        janus = 30805408;
        aegis = 29642951;
        mimir = 32226619;
      };
      type = attrsOf int;
      description = "Attrset of Yubikey serial numbers. NOTE: Yubico's 'Security Key' products do not use unique serial number therefore, the scripts in this module are unable to distinguish between multiple 'Security Key' devices and instead will detect a Security Key serial number as the string \"[FIDO]\". This means you can only use a single Security Key but can still mix it with YubiKey 4 and 5 devices.";
      example = literalExample ''
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
    # make home-manager enable yubikey-touch-detector

    # FIXME: This doesn't work
    # hm.my.yubikey.touchDetector.enable = true;

    # TODO: need to figure out how to use gpg-agent with ssh
    # or just ues ssh-agent with yubikey?
    # can ssh-agent works with yubikey?
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    environment.systemPackages = flatten [
      (builtins.attrValues {
        inherit
          (pkgs)
          yubikey-manager # cli-based authenticator tool. accessed via `ykman`
          age-plugin-yubikey
          pam_u2f # for yubikey with sudo
          ;
      })
      yubikey-up
      yubikey-down
    ];

    # FIXME(yubikey): Put this behind an option for yubikey ssh
    # Create ssh files

    # FIXME(yubikey): Not sure if we need the wheel one. Also my idProduct group is 0407
    # Yubikey 4/5 U2F+CCID
    # SUBSYSTEM == "usb", ATTR{idVendor}=="1050", ENV{ID_SECURITY_TOKEN}="1", GROUP="wheel"
    # We already have a yubikey rule that sets the ENV variable

    # FIXME: This is linux only
    services = optionalAttrs isLinux {
      udev.extraRules = ''
        # Link/unlink ssh key on yubikey add/remove
        SUBSYSTEM=="usb", ACTION=="add", ATTR{idVendor}=="1050", RUN+="${getBin yubikey-up}/bin/yubikey-up"
        # NOTE: Yubikey 4 has a ID_VENDOR_ID on remove, but not Yubikey 5 BIO, whereas both have a HID_NAME.
        # Yubikey 5 HID_NAME uses "YubiKey" whereas Yubikey 4 uses "Yubikey", so matching on "Yubi" works for both
        SUBSYSTEM=="hid", ACTION=="remove", ENV{HID_NAME}=="Yubico Yubi*", RUN+="${getBin yubikey-down}/bin/yubikey-down"

        ##
        # Yubikey 4
        ##

        # Lock the device if you remove the yubikey (use udevadm monitor -p to debug)
        # #ENV{ID_MODEL_ID}=="0407", # This doesn't match all the newer keys
        # FIXME(yubikey): We only want this to happen if we're undocked, so we need to see how that works. We probably need to run a
        # script that does smarter checks
        # ACTION=="remove",\
        #  ENV{ID_BUS}=="usb",\
        #  ENV{ID_VENDOR_ID}=="1050",\
        #  ENV{ID_VENDOR}=="Yubico",\
        #  RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"

        ##
        # Yubikey 5 BIO
        #
        # NOTE: The remove event for the bio doesn't include the ID_VENDOR_ID for some reason, but we can use the
        # hid name instead. Some HID_NAME might be "Yubico YubiKey OTP+FIDO+CCID" or "Yubico YubiKey FIDO", etc so just
        # match on "Yubico YubiKey"
        ##

        # SUBSYSTEM=="hid",\
        #  ACTION=="remove",\
        #  ENV{HID_NAME}=="Yubico YubiKey FIDO",\
        #  RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"

        # FIXME(yubikey): Change this so it only wakes up the screen to the login screen, xset cmd doesn't work
        # SUBSYSTEM=="hid",\
        #  ACTION=="add",\
        #  ENV{HID_NAME}=="Yubico YubiKey FIDO",\
        #  RUN+="${pkgs.systemd}/bin/loginctl activate 1"
        #  #RUN+="${getBin pkgs.xorg.xset}/bin/xset dpms force on"
      '';
    };
  };
}
