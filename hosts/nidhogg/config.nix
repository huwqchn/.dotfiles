{
  config,
  lib,
  ...
}: {
  wsl = {
    enable = true;
    defaultUser = config.my.name;
    interop.register = true;
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = true;

    # Generic WSL settings
    wslConf = {
      # automount.root = "/mnt";
      network.generateResolvConf = false;
    };
  };
  my.desktop.enable = true;
  # Required by nixos-wsl
  boot.loader.systemd-boot.enable = lib.mkForce false;
  networking.firewall.enable = lib.mkForce false;
  networking.useNetworkd = lib.mkForce false;
  networking.nftables.enable = lib.mkForce false;
  networking.extraHosts = lib.mkForce '''';
  services.greetd.enable = lib.mkForce false;
  services.pipewire.enable = lib.mkForce false;

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
