{ inputs, lib, ... }: {
  flake = lib.mkHosts ../hosts;
}
