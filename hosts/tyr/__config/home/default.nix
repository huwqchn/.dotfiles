{config, ...}: {
  home-manager.users."${config.my.name}".imports = [
    ../../../../home/darwin.nix
    ./nvim.nix
  ];
}
