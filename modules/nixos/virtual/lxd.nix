# Inspired by https://www.srid.ca/2012301.html
{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.my.virtual.lxd;
in {
  options.modules.virtual.lxd = {
    enable = mkEnableOption "Enable LXD";
  };

  config = mkIf cfg.enable {
    virtualisation.lxd.enable = true;

    user.packages = [
      (pkgs.writeScriptBin "lxc-build-nixos-image" ''
        #!/usr/bin/env nix-shell
        #!nix-shell -i bash -p nixos-generators
        set -xe
        config=$1
        metaimg=`nixos-generate -f lxc-metadata \
          | xargs -r cat \
          | awk '{print $3}'`
        img=`nixos-generate -c $config -f lxc \
          | xargs -r cat \
          | awk '{print $3}'`
        lxc image import --alias nixos $metaimg $img
      '')
    ];
  };
}
