{
  config,
  lib,
  hostName,
  ...
}: let
  inherit (builtins) hasAttr;
  inherit (lib.strings) optionalString;
  inherit (config.my) name home machine;
  hostPath = ../../hosts/${config.networking.hostName}/host.pub;
  userPath = ../../secrets/${name}/ssh.pub;
  dirname =
    if (hasAttr "networking" config)
    then config.networking.hostName
    else name + "@" + hostName;
  sshDir = home + "/.ssh";
  inherit (machine) persist;
in {
  # Setup secret rekeying parameters
  age = {
    # check the main users ssh key and the system key to see if it is safe
    # to decrypt the secrets
    identityPaths = [
      "${optionalString persist "/persist"}/etc/ssh/ssh_host_ed25519_key"
      "${optionalString persist "/persist"}/${sshDir}/id_${name}"
    ];

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
