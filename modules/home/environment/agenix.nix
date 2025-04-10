{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.home) homeDirectory;
  isLinuxSystemd = pkgs.stdenv.isLinux && config.systemd.user.services ? agenix;
in {
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
    ../../common/agenix.nix
  ];

  age = {
    secretsDir = "${homeDirectory}/.agenix";
    secretsMountPoint = "${homeDirectory}/.agenix/agenix.d";
  };

  home.activation.agenix = lib.hm.dag.entryAfter ["writeBoundary"] (
    if isLinuxSystemd
    then ''
      ${config.systemd.user.services.agenix.Service.ExecStart}
    ''
    else ""
  );
}
