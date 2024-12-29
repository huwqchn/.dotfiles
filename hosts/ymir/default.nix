{ nixos-generators, programs-sqlite, home-manager, mylib, myvars, ... }: {
  modules = [
    ../../modules/nixos
    ./__config
    home-manager.nixosModules.home-manager
    nixos-generators.nixosModules.all-formats
    programs-sqlite.nixosModules.programs-sqlite
    {
      home-manager = {
        users."${myvars.userName}".imports = [
          mylib.relativeToRoot "home"
        ];
      };
    }
  ];
}
