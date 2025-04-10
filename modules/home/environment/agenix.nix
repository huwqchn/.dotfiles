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
    package = pkgs.rage;
    secretsDir = "${homeDirectory}/.secrets";
    secretsMountPoint = "${homeDirectory}/.agenix/";
  };

  home.packages = with pkgs; [
    rage
  ];

  # You must set this, if you want to use agenix home manager module on nixos
  # see: https://github.com/ryantm/agenix/issues/50#issuecomment-1926893522
  home.activation.agenix = lib.hm.dag.entryAfter ["writeBoundary"] (
    if isLinuxSystemd
    then ''
      ${config.systemd.user.services.agenix.Service.ExecStart}
    ''
    else ""
  );
}
