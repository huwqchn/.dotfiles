{config, ...}: {
  home-manager.users."${config.my.name}".imports = [../../../../home ./nvim.nix ./desktop.nix];
}
