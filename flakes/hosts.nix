{ inputs, lib, ... } @ args: {
  flake = lib.mkHosts ../hosts args;
}
