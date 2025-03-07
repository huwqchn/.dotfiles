{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devshells.default = {
      # NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
      packages = [config.treefmt.build.wrapper pkgs.nix-diff];
      name = "dots";
      # shellHook = ''
      #   ${config.pre-commit.installationScript}
      # '';
    };
  };
}
