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
      keyboard = {
        inherit (my.keyboard) layout kanata;
      };
      desktop = {
        inherit (my.desktop) enable type name;
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
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    # FIXME: this is not work
    useUserPackages = true;
  };
}
