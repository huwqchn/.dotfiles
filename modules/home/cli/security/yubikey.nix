{
  self,
  config,
  ...
}: let
  inherit (config.home) homeDirectory;
in {
  sops.secrets.u2f_keys = {
    sopsFile = "${self}/secrets/default.yaml";
    path = "${homeDirectory}/.config/Yubico/u2f_keys";
  };
}
