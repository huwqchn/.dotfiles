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
      # allow root login to remote deployments
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # It's default to true
      # allowSFTP = true;

      # Use key exchange algorithms recommended by `nixpkgs#ssh-audit`
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "sntrup761x25519-sha512@openssh.com"
        "diffie-hellman-group-exchange-sha256"
        "mlkem768x25519-sha256"
        "sntrup761x25519-sha512"
      ];

      # Use Macs recommended by `nixpkgs#ssh-audit`
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];

      # kick out inactive sessions
      ClientAliveCountMax = 5;
      ClientAliveInterval = 60;
    };
    openFirewall = true;
    # the port(s) openssh daemon should listen on
    ports = [22];
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
  };
}
