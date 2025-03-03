{
  config,
  lib,
  ...
}: {
  home-manager.users."${config.my.name}".imports = [lib.my.relativeToRoot "home" ./home/nvim.nix];
}
