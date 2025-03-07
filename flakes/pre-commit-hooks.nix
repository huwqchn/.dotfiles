{inputs, ...}: {
  imports = [inputs.pre-commit-hooks.flakeModule];

  perSystem.pre-commit = {
    settings = {
      excludes = [
        "flake.lock"
        ".direnv"
      ];
      hooks = {
        check-added-large-files = {
          enable = true;
          excludes = ["\\.png" "\\.jpg"];
        };
        check-case-conflicts.enable = true;
        check-executables-have-shebangs.enable = true;
        # many of the scripts in the config aren't executable because they don't need to be.
        check-shebang-scripts-are-executable.enable = false;
        check-merge-conflicts.enable = true;
        detect-private-keys.enable = true;
        fix-byte-order-marker.enable = true;
        mixed-line-endings.enable = true;
        trim-trailing-whitespace.enable = true;
        end-of-file-fixer.enable = true;
        detect-private-keys.enable = true;
        actionlint.enable = true;

        forbid-submodules = {
          enable = true;
          name = "forbid submodules";
          description = "forbids any submodules in the repository";
          language = "fail";
          entry = "submodules are not allowed in this repository:";
          types = ["directory"];
        };

        treefmt.enable = true;
      };
    };
  };
}
