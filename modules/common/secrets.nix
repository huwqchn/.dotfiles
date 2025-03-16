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
    inherit
      (self.secretsConfig)
      masterIdentities
      extraEncryptionPubkeys
      ;
    hostPubkey = config.my.secretsDir + "/host.pub";
    storageMode = "local";
    generatedSecretsDir = self.outPath + "/secrets/generated/${config.networking.hostName}";
    localStorageDir = self.outPath + "/secrets/rekeyed/${config.networking.hostName}";
  };
  system.activationScripts = lib.mkIf (config.age.secrets != {}) {
    removeAgenixLink.text = "[[ ! -L /run/agenix ]] && [[ -d /run/agenix ]] && rm -rf /run/agenix";
    agenixNewGeneration.deps = ["removeAgenixLink"];
  };
}
