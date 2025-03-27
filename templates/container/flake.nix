{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (_: {
          boot.isContainer = true;

          # Let 'nixos-version --json' know about the Git revision
          # of this flake.
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

          # Network configuration.
          networking.useDHCP = false;
          networking.firewall.allowedTCPPorts = [80];

          # Enable a web server.
          services.httpd = {
            enable = true;
            adminAddr = "johnson.wq.hu@gmail.com";
          };
        })
      ];
    };
  };
}
