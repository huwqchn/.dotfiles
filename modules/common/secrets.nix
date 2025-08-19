{
  config,
  self,
  lib,
  ...
}: let
  inherit (lib.strings) optionalString;
  inherit (config.my) home;
  persist = config.my.persistence.enable;
in {
  sops = {
    defaultSopsFile = "${self}/secrets/default.yaml";
    # Use user's age key as primary method (no root required)
    age.keyFile = "${home}/.config/sops/age/keys.txt";
    # SSH host key as fallback (requires root, but available on system rebuild)
    age.sshKeyPaths = ["${optionalString persist "/persist"}/etc/ssh/ssh_host_ed25519_key"];
    # Keep GPG support for Yubikey when available
    gnupg.home = "${home}/.gnupg";
  };
}
