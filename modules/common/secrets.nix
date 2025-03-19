{
  inputs,
  self,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.agenix-rekey.nixosModules.default
  ];
  # Setup secret rekeying parameters
  age.rekey = {
    masterIdentities = ["${self}/secrets/janus.pub"];
    extraEncryptionPubkeys = ["${self}/secrets/backup.pub"];
    hostPubkey = "/etc/ssh/ssh_host_ed25519_key.pub";
    storageMode = "local";
    generatedSecretsDir = ../../. + "/secrets/generated/${config.networking.hostName}";
    localStorageDir = ../../. + "/secrets/rekeyed/${config.networking.hostName}";
  };
  system.activationScripts = lib.mkIf (config.age.secrets != {}) {
    removeAgenixLink.text = "[[ ! -L /run/agenix ]] && [[ -d /run/agenix ]] && rm -rf /run/agenix";
    agenixNewGeneration.deps = ["removeAgenixLink"];
  };
}
