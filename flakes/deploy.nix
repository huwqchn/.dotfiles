{
  inputs,
  lib,
  self,
  ...
}: let
  inherit (builtins) mapAttrs readDir import pathExists;

  # Read host configurations from filesystem directly to determine deployable hosts
  # This works similar to flake-hosts logic but uses our existing host directory structure
  hostsDir = ../hosts;
  hostDirEntries = readDir hostsDir;

  # Load a host configuration, checking both .nix files and directories with default.nix
  loadHostConfig = name: let
    filePath = "${hostsDir}/${name}.nix";
    dirPath = "${hostsDir}/${name}/default.nix";
  in
    if pathExists filePath
    then import filePath
    else if pathExists dirPath
    then import dirPath
    else {};

  # Get all potential host names (excluding default and default.nix)
  allHostNames = lib.filter (
    name:
      name
      != "default"
      && name != "default.nix"
      && name != "common"
      && name != "installer"
  ) (lib.attrNames hostDirEntries);

  # Filter to deployable hosts and create system configurations
  # A host is deployable if it explicitly sets deployable = true and has a valid system (not home/nixOnDroid)
  deployableSystems = lib.listToAttrs (lib.concatMap (
      name: let
        hostConfig = loadHostConfig name;
        isDeployable = hostConfig.deployable or false;
        hostClass = hostConfig.class or "nixos"; # Default to nixos
        hasValidSystem = hostClass == "nixos" || hostClass == "darwin"; # Only nixos/darwin are deployable
      in
        if isDeployable && hasValidSystem && (self.nixosConfigurations.${name} or self.darwinConfigurations.${name} or null) != null
        then [
          {
            inherit name;
            value =
              if hostClass == "darwin"
              then self.darwinConfigurations.${name}
              else self.nixosConfigurations.${name};
          }
        ]
        else []
    )
    allHostNames);
in {
  flake.deploy = {
    autoRollback = true;
    magicRollback = true;

    # then create a list of nodes that we want to deploy that we can pass to the deploy configuration
    nodes =
      mapAttrs (name: systemConfig: let
        hostConfig = loadHostConfig name;
        hostClass = hostConfig.class or "nixos";
        hostArch = hostConfig.arch or "x86_64";
        systemString =
          if hostClass == "darwin"
          then "${hostArch}-darwin"
          else "${hostArch}-linux";
      in {
        hostname = name;
        profiles.system = {
          user = "root";
          sshUser = systemConfig.config.my.name or "root";
          path =
            if hostClass == "darwin"
            then inputs.deploy-rs.lib.${systemString}.activate.darwin systemConfig
            else inputs.deploy-rs.lib.${systemString}.activate.nixos systemConfig;
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
