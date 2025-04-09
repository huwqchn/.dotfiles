{
  inputs,
  lib,
  self,
  ...
}: let
  inherit (builtins) mapAttrs;
  inherit (lib.attrsets) filterAttrs;

  # extract the systems that we want to deploy
  deployableSystems = filterAttrs (_: attrs: attrs.deployable) self.nodes;
in {
  flake.deploy = {
    autoRollback = true;
    magicRollback = true;

    # then create a list of nodes that we want to deploy that we can pass to the deploy configuration
    nodes =
      mapAttrs (name: node: {
        hostname = name;
        profiles.system = {
          user = "root";
          sshUser = node.config.my.name or "root";
          path = inputs.deploy-rs.lib.${node.system}.activate.nixos node;
        };
      })
      deployableSystems;
  };

  perSystem = {inputs', ...}: {
    # checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
    devshells.default = {
      commands = [
        {
          name = "deploy";
          help = "deploy to remote hosts";
          package = inputs'.deploy-rs.packages.default;
        }
      ];
    };

    apps = {
      # Deploy
      default = {
        type = "app";
        program = "${inputs'.deploy-rs.packages.deploy-rs}/bin/deploy";
      };
    };
  };
}
