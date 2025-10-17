{
  self,
  inputs,
  ...
}: {
  # Global nixpkgs configuration. This is ignored if nixpkgs.pkgs is set
  # which is a case that should be avoided. Everything that is set to configure
  # nixpkgs must go here.
  nixpkgs = {
    # Configuration reference:
    # <https://nixos.org/manual/nixpkgs/unstable/#chap-packageconfig>
    config = {
      # Allow broken packages to be built. Setting this to false means packages
      # will refuse to evaluate sometimes, but only if they have been marked as
      # broken for a specific reason. At that point we can either try to solve
      # the breakage, or get rid of the package entirely.
      allowBroken = false;

      # Allow unsupported system packages to be built.
      allowUnsupportedSystem = true;

      # Really a pain in the ass to deal with when disabled. True means
      # we are able to build unfree packages without explicitly allowing
      # each unfree package.
      allowUnfree = true;

      # Default to none, add more as necessary. This is usually where
      # electron packages go when they reach EOL.
      permittedInsecurePackages = [];

      # Nixpkgs sets internal package aliases to ease migration from other
      # distributions easier, or for convenience's sake. Even though the manual
      # and the description for this option recommends this to be true
      allowAliases = true;

      # Enable parallel building by default. This, in theory, should speed up building
      # derivations, especially rust ones. However setting this to true causes a mass rebuild
      # of the *entire* system closure, so it must be handled with proper care.
      enableParallelBuildingByDefault = false;

      # List of derivation warnings to display while rebuilding.
      #  See: <https://github.com/NixOS/nixpkgs/blob/master/pkgs/stdenv/generic/check-meta.nix>
      # NOTE: "maintainerless" can be added to emit warnings
      # about packages without maintainers but it seems to me
      # like there are more packages without maintainers than
      # with maintainers, so it's disabled for the time being.
      showDerivationWarnings = [];
    };
    overlays =
      (builtins.attrValues self.overlays)
      ++ [
        inputs.emacs-overlay.overlay
        (_final: prev: {
          vimPlugins =
            prev.vimPlugins
            // {
              project-nvim = prev.vimUtils.buildVimPlugin {
                pname = "project.nvim";
                version = "2025-10-18";
                src = prev.fetchFromGitHub {
                  owner = "ahmedkhalf";
                  repo = "project.nvim";
                  rev = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb";
                  hash = "sha256-avV3wMiDbraxW4mqlEsKy0oeewaRj9Q33K8NzWoaptU=";
                };
              };
              venv-selector-nvim = prev.vimUtils.buildVimPlugin {
                pname = "venv-selector.nvim";
                version = "2025-10-18";
                src = prev.fetchFromGitHub {
                  owner = "linux-cultist";
                  repo = "venv-selector.nvim";
                  rev = "7fff64b5b1455207b9a9fd2ae8697cf9ac0b2a2d";
                  hash = "sha256-m165YyY8VX0YQ5v6vxDJp4avDRrxByZQY+uMNkubggo=";
                };
              };
            };
        })
        (_final: prev: {
          qt6Packages = prev.qt6Packages.overrideScope (
            _qt6final: qt6prev: {
              fcitx5-with-addons = qt6prev.fcitx5-with-addons.override {withConfigtool = false;};
            }
          );
        })
      ];
  };
}
