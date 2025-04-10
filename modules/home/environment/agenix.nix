{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.home) homeDirectory;
  inherit (lib.modules) mkIf;
  isLinuxSystemd = pkgs.stdenv.isLinux && config.systemd.user.services ? agenix;
in {
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
    ../../common/agenix.nix
  ];

  age = {
    package = pkgs.rage;
    secretsDir = "${homeDirectory}/.agenix";
    secretsMountPoint = "${homeDirectory}/.agenix/agenix.d";
  };

  home.activation.agenix =
    lib.hm.dag.entryAnywhere mkIf isLinuxSystemd
    config.systemd.user.services.agenix.Service.ExecStart;
}
