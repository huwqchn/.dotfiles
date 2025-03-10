{
  config,
  lib,
  ...
}: {
  system.stateVersion = "24.11";
  wsl = {
    enable = true;
    defaultUser = config.my.name;
    interop.register = true;
    nativeSystemd = true;
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = true;

    # Generic WSL settings
    wslConf = {
      automount.root = "/mnt";
      network.generateResolvConf = false;
    };
  };
  my.desktop.enable = true;
  # Required by nixos-wsl
  networking.nftables.enable = lib.mkForce false;

  # Suppress warning about this one having no effect
  # we ship adblocking capabilities here usually
  networking.extraHosts = lib.mkForce '''';
  # Use the newer Docker 24
  virtualisation = {
    docker = {
      autoPrune = {
        enable = true;
        flags = ["--all"];
      };
      enable = true;
      enableOnBoot = false;
    };
  };
}
