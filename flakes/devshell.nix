{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devshells.default = {
      packages = [config.treefmt.build.wrapper pkgs.nix-diff];
      name = "dots";
    };
  };
}
