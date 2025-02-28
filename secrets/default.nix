{
  pkgs,
  agenix,
  config,
  ...
}: let
  user_readable = {
    symlink = false;
    owner = config.my.name;
    mode = "0500";
  };
in {
  environment.systemPackages = [agenix.packages."${pkgs.system}".default];

  # if you changed this key, you need to regenerate all encrypt files from the decrypt contents!
  age.identityPaths = [
    # using the host key for decryption
    # the host key is generated on every host locally by openssh, and will never leave the host.
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  age.secrets = {
    "git-credentials" =
      {
        # target path for decrypted file
        path = "/home/${config.my.name}/.git-credentials";
        # encrypted file path
        file = ./git-credentials.age;
      }
      // user_readable;

    "johnson-hu-gpg-subkeys.priv.age" =
      {
        path = "/persist/home/${config.my.name}/.gnupg/johnson-hu-gpg-subkeys.priv.age";
        file = ./johnson-hu-gpg-subkeys.priv.age.age;
      }
      // user_readable;

    "johnson-hu-ssh-key.age" =
      {
        path = "/persist/home/${config.my.name}/.ssh/johnson-hu-ssh-key";
        file = ./johnson-hu-ssh-key.age;
      }
      // user_readable;
  };
}
