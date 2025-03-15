{config, ...}: {
  config.my.machine.cpu =
    if config.hardware.cpu.intel.updateMicrocode
    then "intel"
    else "amd";
}
