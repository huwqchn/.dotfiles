{ myvars, ... }: let
  users = [ myvars.sshKey ];
  workstation = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNg9grRNkSbDJCoJh6rZ9ZRWjofSNqQ8bdc4b5guV9M huwqchn@gmail.com";

  # `ssh-keygen -t ed25519 -a 256 -C "my@email.com"`
  recovery_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICs29eqKthmTluNROym8+U9vxfzjlfVq3o3ad5ps+SyI johnson.wq.hu@gmail.com";

  system = [
    workstation

    recovery_key
  ];

in {
  ".github-token".publickey = users ++ system;
}
