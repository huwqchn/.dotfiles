{
  inputs,
  lib,
  self,
  config,
  ...
}: let
  inherit (config.flake-hosts) hosts;

  # Keep only deployable systems based on host config flag
  deployableSystems =
    lib.filterAttrs
    (_name: _value: hosts.deployable or false)
    hosts;
in {
  flake.deploy = {
    autoRollback = true;
    magicRollback = true;

    # then create a list of nodes that we want to deploy that we can pass to the deploy configuration
    nodes =
      builtins.mapAttrs (name: host: let
        node = self."${host.class}Configurations";
      in {
        hostname = name;
        profiles.system = {
          user = "root";
          sshUser = node.config.my.name or "root";
          path = inputs.deploy-rs.lib.${host.system}.activate.${host.class} node;
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
          package = inputs'.deploy-rs.packages.deploy-rs;
          category = "dev";
        }
      ];
    };
  };
}
