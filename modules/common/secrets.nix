{
  config,
  lib,
  ...
}: let
  inherit (lib.strings) optionalString;
  persist = config.my.persistence.enable;
in {
  sops = {
    # System-level SSH host key (for system-wide secrets access)
    age.sshKeyPaths = ["${optionalString persist "/persist"}/etc/ssh/ssh_host_ed25519_key"];
  };
}
