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
  };

  config = mkIf cfg.enable {
    my.virtual = {
      distrobox.enable = mkDefault true;
      docker.enable = mkDefault true;
      lxd.enable = mkDefault true;
      podman.enable = mkDefault true;
      qemu.enable = mkDefault true;
      waydroid.enable = mkDefault true;
    };
  };
}
