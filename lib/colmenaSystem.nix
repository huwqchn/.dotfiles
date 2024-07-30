{
  lib,
  inputs,
  nixos-modules,
  home-modules ? [],
  myvars,
  system,
  tags,
  ssh-user,
  genSpecialArgs,
  specialArgs ? (genSpecialArgs system),
  ...
}: let
  inherit (inputs) home-manager;
in
  {name, ...}: {
    deployment = {
      inherit tags;
      targetUser = ssh-user;
      targetHost = name; # hostName or IP address
    };
    
    imports =
      nixos-modules
      ++ (
        lig.optionals ((lib.lists.length home-modules} > 0)
        [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
           
            home-manager.extrasSpecialArgs = specialArgs;
            home-manager.users."${myvars.userName}".imports = home-modules;
         }
       ]
     );

  }
