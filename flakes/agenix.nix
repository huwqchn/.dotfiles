{
  inputs,
  config,
  self,
  ...
}: {
  imports = [
    inputs.agenix-shell.flakeModules.default # https://github.com/aciceri/agenix-shell
    inputs.agenix-rekey.flakeModule # https://github.com/oddlama/agenix-rekey
  ];

  flake = {
    # The identities that are used to rekey agenix secrets and to decrypt all
    # repository-wide secrets.
    secretsConfig = {
      masterIdentities = [../secrets/janus.pub];
      extraEncryptionPubkeys = [../secrets/backup.pub];
    };
  };

  # Template: https://github.com/aciceri/agenix-shell/blob/master/templates/basic/flake.nix
  agenix-shell = {
    # Default: "git rev-parse --show-toplevel | xargs basename";
    flakeName = "nix-configs";

    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    secretsPath = "/run/user/$(id -u)/agenix-shell/$(${config.agenix-shell.flakeName})/$(uuidgen)";
    secrets = {
      #  <name> = {
      #    file = "secrets/<name>.age";                          # Age file the secret is loaded from
      #    mode = "0400";                                        # Perms mode of the decrypted secret in chmod format
      #    namePath = "<name>_PATH";                             # Variable name containing path to secret
      #    name = "<name>";                                      # Variable name containing secret
      #    path = "${config.agenix-shell.secretsPath}/<name>";   # Path where the decrypted secret is installed.
      #  };
    };
  };

  # agenix-rekey apps specific to your flake.
  #   Used by the agenix wrapper script
  #   Can be run manually using: `nix run .#agenix-rekey.$system.<app>`
  # flake.agenix-rekey = { };

  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    # Agenix extension to avoid `secrets.nix` file by auto re-encrypting secrets where needed.
    #   Allows you to define versatile generators for secrets, so they can be bootstrapped automatically.
    #   This can be used alongside regular use of agenix.
    agenix-rekey = {
      inherit (config.agenix-shell) agePackage;
      collectHomeManagerConfigurations = true;
      # Example: Colmena
      # inherit ((colmena.lib.makeHive self.colmena).introspect (x: x)) nodes;
      # inherit (inputs.self.colmenaHive.introspect (x: x)) nodes;

      nixosConfigurations = self.nixosConfigurations // self.drawinConfigurations;
    };

    agenix-shell = {
      agePackage = pkgs.rage;
      # installationScript = inputs.agenix-shell.packages.${system}.installationScript.override {
      #  agenixShellConfig.secrets = { foo.file = ./secrets/foo.age; };
      # };
    };

    devshells.default = {
      devshell = {
        packagesFrom = [config.agenix-rekey.package];
        startup.agenix-installation = {
          deps = [];
          text = ''
            echo 'Installing secrets from agenix-shell...'
            ${lib.getExe config.agenix-shell.installationScript}
            echo 'Installed secrets from agenix-shell.'
          '';
        };
      };
      commands = [
        # {
        #   category = "agenix";
        #   name = "agenix";
        #   package = inputs'.agenix.packages.default;
        # }
        # {
        #   category = "agenix";
        #   package = config.agenix-shell.installationScript;
        #   help = "Install agenix secrets";
        # }
        {
          inherit (config.agenix-rekey) package;
          help = "Edit, generate and rekey secrets";
        }
      ];
      env = [
        {
          # Always add files to git after agenix rekey and agenix generate.
          name = "AGENIX_REKEY_ADD_TO_GIT";
          value = "true";
        }
      ];
    };
    packages.agenix-install = config.agenix-shell.installationScript;
  };
}
