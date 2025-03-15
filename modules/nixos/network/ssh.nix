{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.security;
in {
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
      openFirewall = true;
    };

    # networking.firewall.allowedTCPPorts = [ 22 ];
    networking.firewall.enable = false;

    # Add terminfo database of all known terminals to the system profile.
    # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/config/terminfo.nix
    environment.enableAllTerminfo = true;
  };
}
