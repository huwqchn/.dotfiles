{
  myvars,
  lib,
  outputs,
}: let
  username = myvars.username;
  hosts = [
    "hacker"
  ];
in
  lib.genAttrs
  hosts
  (
    name: outputs.nixosConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
  )
