{
  lib,
  config,
  ...
}: {
  # Just before switching, remove the agenix directory if it exists.
  # This can happen when a secret is used in the initrd because it will
  # then be copied to the initramfs under the same path. This materializes
  # /run/agenix as a directory which will cause issues when the actual system tries
  # to create a link called /run/agenix. Agenix should probably fail in this case,
  # but doesn't and instead puts the generation link into the existing directory.
  # TODO See https://github.com/ryantm/agenix/pull/187.
  system.activationScripts = lib.mkIf (config.age.secrets != {}) {
    removeAgenixLink.text = "[[ ! -L /run/agenix ]] && [[ -d /run/agenix ]] && rm -rf /run/agenix";
    agenixNewGeneration.deps = ["removeAgenixLink"];
  };
}
