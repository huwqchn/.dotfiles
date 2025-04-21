{config, ...}: let
  inherit (config.home) homeDirectory;
in {
  # for yubikey sudo login
  age.secrets.u2f_keys = {
    rekeyFile = ./secrets/u2f_keys.age;
    path = "${homeDirectory}/.config/Yubico/u2f_keys";
  };
}
