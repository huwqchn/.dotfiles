{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  cfg = config.my.yubikey;
in {
  config = mkIf cfg.enable {
    hardware.gpgSmartcards.enable = true;
    environment.systemPackages = [
      pkgs.yubioath-flutter
    ];

    # TODO: need to figure out how to use gpg-agent with ssh
    # or just ues ssh-agent with yubikey?
    # can ssh-agent works with yubikey?
    programs = {
      ssh.startAgent = mkForce false;

      gnupg.agent = {
        enable = mkForce true;
        enableSSHSupport = mkForce true;
      };
    };
    # Yubikey required services and config. See Dr. Duh NixOS config for
    # reference
    services = {
      pcscd.enable = true;
      udev.packages = [pkgs.yubikey-personalization];
    };
    security.pam = {
      u2f = {
        enable = true;
        settings = {
          cue = true; # Tells user they need to press the button
          authFile = "${config.my.home}/.config/Yubico/u2f_keys";
        };
      };
      services = {
        login.u2fAuth = true;
        sudo = {
          u2fAuth = true;
        };
        # Attempt to auto-unlock gnome-keyring using u2f
        # NOTE: vscode uses gnome-keyring even if we aren't using gnome, which is why it's still here
        # This doesn't work
        #gnome-keyring = {
        #  text = ''
        #    session    include                     login
        #    session optional ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start
        #  '';
        #};
      };
    };
  };
}
