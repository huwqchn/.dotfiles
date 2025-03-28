{
  config,
  lib,
  ...
}: let
  cfg = config.my.virtual;
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.virtual.docker = {
    enable =
      mkEnableOption "Docker"
      // {
        default = config.my.virtual.enable;
      };
  };
  config = mkIf cfg.enable {
    virtualisation = {
      docker = {
        enable = true;
        daemon.settings = {
          # enables pulling using containerd, which supports restarting from a partial pull
          # https://docs.docker.com/storage/containerd/
          "features" = {"containerd-snapshotter" = true;};
        };

        # start dockerd on boot.
        # This is required for containers which are created with the `--restart=always` flag to work.
        enableOnBoot = true;

        # auto prune unused containers and images
        autoPrune = {
          enable = true;
          flags = ["--all"];
        };
      };
    };
  };
}
