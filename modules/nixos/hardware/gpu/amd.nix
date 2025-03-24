{
  lib,
  pkgs,
  config,
  ...
}: let
  isAmd = config.my.machine.gpu == "amd";
  inherit (lib) mkIf;
in {
  config = mkIf isAmd {
    # enable amdgpu xorg drivers
    services.xserver.videoDrivers = ["amdgpu"];

    # enable amdgpu kernel module
    boot = {
      kernelModules = ["amdgpu"];
      initrd.kernelModules = ["amdgpu"];
    };

    # enables AMDVLK & OpenCL support
    hardware.graphics.extraPackages = with pkgs.rockPackages; [
      clr
      clr.icd
    ];
  };
}
