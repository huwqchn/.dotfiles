{
  config,
  self,
  ...
}: let
  inherit (config.my) home;
in {
  sops = {
    defaultSopsFile = "${self}/secrets/default.yaml";
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    gnupg.home = "${home}/.gnupg";
  };
}
