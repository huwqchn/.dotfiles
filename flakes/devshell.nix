{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    BOOTSTRAP_USER = "johnson";
    BOOTSTRAP_SSH_PORT = "22";
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
        ${config.per-commit.installationScript}
      '';
      # formatter = pkgs.alejandra;
    };
  };
}
