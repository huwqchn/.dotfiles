{ inputs, mylib, myvars, ... }: let
  inherit (myvars) username;
  inherit (inputs) nixpkgs;
in {

  imports = [
    ../modules/nix.nix
    ./system.nix
    ./user.nix
    ./apps.nix
  ];


  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs mylib myvars;};
    users.${username} = {
      imports = [
        ../home/git.nix
	      ../home/nvim.nix
        ../home/home.nix
      ];
    };
  };
}
