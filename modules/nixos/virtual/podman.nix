{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.my.virtual;
in {
  options.my.virtual.podman = {
    enable = mkEnableOption "Enable podman";
  };

  config = mkIf (cfg.docker.enable || cfg.podman.enable) {
    environment.systemPackages = with pkgs; [
      podman-compose
      podman-desktop
    ];

    virtualisation = {
      # Registries to search for images on `podman pull`
      containers.registries.search = [
        "docker.io"
        "quay.io"
        "ghcr.io"
        "gcr.io"
      ];

      podman = {
        enable = true;

        # Make Podman backwards compatible with Docker socket interface.
        # Certain interface elements will be different, but unless any
        # of said values are hardcoded, it should not pose a problem
        # for us.
        dockerCompat = true;
        dockerSocket.enable = true;

        defaultNetwork.settings.dns_enabled = true;

        # Enable Nvidia support for Podman if the Nvidia drivers are found
        # in the list of xserver.videoDrivers.
        enableNvidia = builtins.any (driver: driver == "nvidia") config.my.machine.gpu;

        # Prune images and containers periodically
        autoPrune = {
          enable = true;
          flags = ["--all"];
          dates = "weekly";
        };
      };
    };
  };
}
