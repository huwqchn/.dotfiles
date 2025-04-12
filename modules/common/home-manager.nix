{
  self,
  self',
  inputs,
  inputs',
  pkgs,
  pkgs',
  lib,
  config,
  hostName,
  ...
}: let
  extraSpecialArgs = {inherit self self' inputs inputs' pkgs pkgs' lib hostName;};
in {
  imports = [
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" config.my.name])
  ];

  hm.imports = [../home];

  home-manager = {
    inherit extraSpecialArgs;
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    # do not enable home-manager.useUserPackages, to match standalone home-manager,
    # so home-manager/nixos-rebuild/darwin-rebuild can be used at the same time
    # home-manager.useUserPackages = true;
  };
}
