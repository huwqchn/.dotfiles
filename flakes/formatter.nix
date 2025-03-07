{ inputs, ... }: {
  import = [ inputs.treefmt.flakeModule ];
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      alejandra.enable = true;
      deadnix.enable = true;
      prettier.enable = true;
      statix.enable = true;
      stylua.enable = true;
      yamlfmt.enable = true;
      shfmt.enable = true;
      shellcheck.enable = true;
    };

    settings = {
      global.excludes = [
        "hosts/hardware-*.nix"
        "LICENSE"
        # unsupported extensions
        "*.{gif,png,svg,tape,mts,lock,mod,sum,toml,env,envrc,gitignore}"
      ];
      formatter = {
        deadnix = {
          priority = 1;
        };

        statix = {
          priority = 2;
        };

        alejandra = { priority = 3; };

        prettier = {
          settings = {
            write = true; # Automatically format files
            configPath = "../.prettierrc.yaml"; # relative to the flake root
          };
          includes = [ "*.{css,html,js,json,jsx,md,mdx,scss,ts,yaml}" ];
        };
        shellcheck = {
          options = [
            "--external-sources"
            "--source-path=SCRIPTDIR"
          ];
          excludes = [
            "gdb/*"
            "zsh/*"
          ];
        };
        shfmt = {
          includes = [
            "*.envrc"
            "*.zshrc"
          ];
          excludes = [
            "gdb/*"
            "zsh/*"
          ];
        };
      };
    };
  };
}
