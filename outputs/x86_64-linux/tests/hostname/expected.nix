{
  lib,
  outputs,
}: let
  hostName = builtins.attrNames outputs.nixosConfigurations;
in
 lib.genAttrs hostName (name : name)
