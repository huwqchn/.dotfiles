{
  myvars,
  lib,
}: let
  username = myvars.username;
  hosts = [
    "hacker"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
