{config, ...}: {
  system.stateVersion = "24.11";
  wsl = {
    enable = true;
    defaultUser = config.my.name;
    docker-desktop.enable = true;
  };
  my = {
    desktop.enable = true;
  };
}
