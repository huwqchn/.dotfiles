{
  config,
  lib,
  ...
}:
with lib; {
  config.my.machine = {
    cpu =
      if config.hardware.cpu.intel.updateMicrocode
      then "intel"
      else "amd";
    gpu =
      optional config.services.xserver.videoDriver == "nvidia" "nvidia";
  };
}
