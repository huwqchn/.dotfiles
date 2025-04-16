{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.home) homeDirectory;
  isLinuxSystemd = pkgs.stdenv.hostPlatform.isLinux && config.systemd.user.services ? agenix;
in {
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
    ../../common/agenix.nix
  ];

  age = {
    package = pkgs.rage;
    # FIXME: use XDG_SECRET_DIR
    secretsDir = "${homeDirectory}/.secrets/agenix";
    secretsMountPoint = "${homeDirectory}/.secrets/agenix.d";
  };

  home = {
    # some security tools
    packages = with pkgs; [
      rage
      age
      sops
      rclone
    ];

    # You must set this, if you want to use agenix home manager module on nixos
    # see: https://github.com/ryantm/agenix/issues/50#issuecomment-1926893522
    activation.agenix = lib.hm.dag.entryAfter ["writeBoundary"] (
      if isLinuxSystemd
      then ''
        ${config.systemd.user.services.agenix.Service.ExecStart}
      ''
      else ""
    );
  };
}
