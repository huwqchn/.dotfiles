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
    age.sshKeyPaths = ["${optionalString persist "/persist"}/etc/ssh/ssh_host_ed25519_key"];
    gnupg.home = "${home}/.gnupg";
  };
}
