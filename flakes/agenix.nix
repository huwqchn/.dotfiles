{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.agenix-rekey.flakeModule
  ];

  perSystem = {config, ...}: {
    agenix-rekey = {
      nixosConfigurations = self.nixosConfigurations // self.darwinConfigurations;
      # homeConfigurations = self.homeConfigurations;
      collectHomeManagerConfigurations = true;
    };
    devshells.default = {
      commands = [
        {
          inherit (config.agenix-rekey) package;
          help = "Edit, generate and rekey secrets";
          category = "dev";
        }
      ];
      env = [
        {
          # Always add files to git after agenix rekey and agenix generate.
          name = "AGENIX_REKEY_ADD_TO_GIT";
          value = "true";
        }
        # {
        #   # Additionally configure nix-plugins with our extra builtins file.
        #   # We need this for our repo secrets.
        #   name = "NIX_CONFIG";
        #   value = ''
        #     plugin-files = ${pkgs.nix-plugins}/lib/nix/plugins
        #     extra-builtins-file = ${self}/scripts/extra-builtins.nix
        #   '';
        # }
      ];
    };
  };
}
