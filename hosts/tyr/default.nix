{ darwin, home-manager, myvars, mylib, ... }: {
  system = "aarch64-darwin";

  modules = [
    ../../modules/darwin
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        users."${myvars.userName}".imports = map mylib.relativeToRoot [
          "home/darwin.nix"
        ];
      };
    }
  ];
  output = "darwinConfigurations";
  builder = darwin.lib.darwinSystem;
}
