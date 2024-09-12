{
  pkgs,
  agenix,
  myvars,
  ...
}: let
  user_readable = {
    symlink = false;
    owner = myvars.userName;
    mode = "0500";
  };
in {
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
    "git-credentials" =
      {
        # target path for decrypted file
        path = "/home/${myvars.userName}/.git-credentials";
        # encrypted file path
        file = ./git-credentials.age;
      }
      // user_readable;

    "johnson-hu-gpg-subkeys.priv.age" =
      {
        path = "/home/${myvars.userName}/.gnupg/johnson-hu-gpg-subkeys.priv.age";
        file = ./johnson-hu-gpg-subkeys.priv.age.age;
      }
      // user_readable;

    "johnson-hu-ssh-key.age" =
      {
        path = "/home/${myvars.userName}/.ssh/johnson-hu-ssh-key";
        file = ./johnson-hu-ssh-key.age;
      }
      // user_readable;
  };
}
