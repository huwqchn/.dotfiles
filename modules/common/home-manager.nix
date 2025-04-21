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
      inherit (my) name fullName email shell home;
      desktop = {
        inherit (my.desktop) enable type environment;
      };
      security = {
        inherit (my.security) enable;
      };
      theme = {
        inherit (my.theme) name cursor avatar wallpaper tokyonight colorscheme;
      };
      persistence = {
        inherit (my.persistence) enable;
      };
      machine = {
        inherit (my.machine) type gpu cpu monitors hasHidpi;
      };
    };
  };

  home-manager = {
    inherit extraSpecialArgs;
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    # do not enable home-manager.useUserPackages, to match standalone home-manager,
    # so home-manager/nixos-rebuild/darwin-rebuild can be used at the same time
    # home-manager.useUserPackages = true;
  };
}
