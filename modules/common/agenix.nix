{
  config,
  lib,
  hostName,
  ...
}: let
  inherit (builtins) hasAttr;
  inherit (lib.lists) optional;
  inherit (lib.strings) optionalString;
  inherit (config.my) name home;
  hostPath = ../../hosts/${config.networking.hostName}/host.pub;
  userPath = ../../secrets/${name}/ssh.pub;
  dirname =
    if (hasAttr "networking" config)
    then config.networking.hostName
    else name + "-" + hostName;
  sshDir = home + "/.ssh";
  persist = config.my.persistence.enable;
  hostIdentityPath = "${optionalString persist "/persist"}/etc/ssh/ssh_host_ed25519_key";
  userIdentityPath = "${optionalString persist "/persist"}${sshDir}/id_${name}";
  # cause first boot can't get the home-level identity key
  isUserIdentityKeyExists = builtins.pathExists userIdentityPath;
in {
  # Setup secret rekeying parameters
  age = {
    # check the main users ssh key and the system key to see if it is safe
    # to decrypt the secrets
    identityPaths =
      [
        hostIdentityPath
      ]
      ++ optional isUserIdentityKeyExists userIdentityPath;

    rekey = {
      masterIdentities = [
        ../../secrets/janus.pub
      ];
      extraEncryptionPubkeys = [
        ../../secrets/backup.pub
      ];
      hostPubkey =
        if (hasAttr "networking" config)
        then hostPath
        else userPath;
      storageMode = "local";
      generatedSecretsDir = ../../. + "/secrets/generated/${dirname}";
      localStorageDir = ../../. + "/secrets/rekeyed/${dirname}";
    };
  };
}
