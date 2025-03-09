{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devshells.default = {
      devshell = {
        name = "dots";
        startup = {
          pre-commit.text = config.pre-commit.installationScript;
        };
      };
      packages = [pkgs.nix];
      commands = [
        {
          package = config.treefmt.build.wrapper;
          help = "Format all files";
        }
        {
          package = pkgs.nix-tree;
          help = "Interactively browse dependency graphs of Nix derivations";
        }
        {
          package = pkgs.nvd;
          help = "Diff two nix toplevels and show which packages were upgraded";
        }
        {
          package = pkgs.nix-diff;
          help = "Explain why two Nix derivations differ";
        }
        {
          package = pkgs.nix-output-monitor;
          help = "Nix Output Monitor (a drop-in alternative for `nix` which shows a build graph)";
        }
      ];
    };
  };
}
