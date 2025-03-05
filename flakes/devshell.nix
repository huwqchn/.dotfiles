{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devshells.default = {
      packages = with pkgs; [
        bashInteractive
        gcc
        alejandra
        deadnix
        statix
        # typos
        nodePackages.prettier
        nix-diff
      ];
      name = "dots";
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
      # formatter = pkgs.alejandra;
    };
  };
}
