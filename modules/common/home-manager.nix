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
  inherit (config) my;
in {
  imports = [
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" config.my.name])
  ];

  hm = {
    imports = [../home];
    my = {
      inherit (my) name fullName email shell home keyboard theme persistence;

      # We do not inherit `my` directly from `config` because NixOS declares options that should not flow into home-manager.
      machine = {
        inherit (my.machine) type gpu cpu monitors hasHidpi;
      };
      desktop = {
        inherit (my.desktop) enable type default;
      };

      security = {
        inherit (my.security) enable;
      };
    };
  };

  home-manager = {
    inherit extraSpecialArgs;
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    # FIXME: this is not work
    useUserPackages = true;
  };
}
