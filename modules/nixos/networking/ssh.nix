{
  lib,
  config,
  ...
}: let
  inherit (lib.strings) optionalString;
  inherit (config.my.machine) persist;
in {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
    hostKeys = [
      {
        path = "${optionalString persist "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "${optionalString persist "/persist"}/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
    ];
    openFirewall = true;
  };

  # networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.enable = false;

  # Add terminfo database of all known terminals to the system profile.
  # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/config/terminfo.nix
  environment.enableAllTerminfo = true;
}
