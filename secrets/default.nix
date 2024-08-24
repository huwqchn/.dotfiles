{ pkgs, agenix, myvars, ... }: {
  imports = [
    agenix.nixosModules.default
  ];

  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ];

  # if you changed this key, you need to regenerate all encrypt files from the decrypt contents!
  age.identityPaths = [
    # using the host key for decryption
    # the host key is generated on every host locally by openssh, and will never leave the host.
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  age.secrets = {
    "git-credentials" = {
      # whether secrets are symlinked to age.secrets.<name>.path
      symlink = true;
      # target path for decrypted file
      path = "/home/${myvars.userName}/.git-credentials";
      # encrypted file path
      file = ./git-credentials.age;
      mode = "0700";
      owner = "${myvars.userName}";
    };
    "gihtub-copilot-hosts.json" = {
      # whether secrets are symlinked to age.secrets.<name>.path
      symlink = true;
      # target path for decrypted file
      path = "/home/${myvars.userName}/.config/github-copilot/hosts.json";
      # encrypted file path
      file = ./github-copilot-hosts.age;
      mode = "0700";
      owner = "${myvars.userName}";
    };
  };
}
