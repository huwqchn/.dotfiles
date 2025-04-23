{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
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
    activation = mkIf isLinuxSystemd {
      agenix = lib.hm.dag.entryAfter ["writeBoundary"] config.systemd.user.services.agenix.Service.ExecStart;
    };
  };
}
