{
  config,
  self,
  ...
}: let
  inherit (config.my) home;
in {
  sops = {
    defaultSopsFile = "${self}/secrets/default.yaml";
    gnupg.home = "${home}/.gnupg";
  };
}
