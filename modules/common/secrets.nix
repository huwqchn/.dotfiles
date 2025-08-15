{config, ...}: let
  inherit (config.my) home;
in {
  sops.gnupg.home = "${home}/.gnupg";
}
