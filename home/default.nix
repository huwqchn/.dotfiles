{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" config.my.name])
  ];

  hm.imports = lib.my.scanPaths ./. ++ [../modules/common/my.nix];

  home-manager = {
    extraSpecialArgs = inputs;
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    # do not enable home-manager.useUserPackages, to match standalone home-manager,
    # so home-manager/nixos-rebuild/darwin-rebuild can be used at the same time
    # home-manager.useUserPackages = true;
  };
}
