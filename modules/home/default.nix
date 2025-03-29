{
  self,
  self',
  inputs,
  inputs',
  pkgs,
  pkgs',
  lib,
  config,
  ...
}: let
  extraSpecialArgs = {inherit self self' inputs inputs' pkgs pkgs' lib;};
in {
  imports =
    [
      (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" config.my.name])
    ]
    ++ (lib.my.scanPaths ./.);

  hm.imports = [../../home];

  home-manager = {
    inherit extraSpecialArgs;
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    # do not enable home-manager.useUserPackages, to match standalone home-manager,
    # so home-manager/nixos-rebuild/darwin-rebuild can be used at the same time
    # home-manager.useUserPackages = true;
  };
}
