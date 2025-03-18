{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.virtual;
in {
  imports = my.scanPaths ./.;
  options.my.virtual = {
    enable = mkEnableOption "Enable virtualisation";
    podman = {
      enable = mkEnableOption "Enable podman";
    };
    docker = {
      enable = mkEnableOption "Enable docker";
    };
  };

  config = {
    assertions = [
      {
        assertion = !(cfg.docker.enable && cfg.podman.enable);
        message = "You can't enable both Docker and Podman at the same time. Please enable only one of them!";
      }
    ];
  };
}
